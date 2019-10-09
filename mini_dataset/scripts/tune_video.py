import argparse

from bitstring import ConstBitStream

from pybzparse import Parser, boxes as bx_def
from pybzparse.headers import BoxHeader


def tune_video(filename, im_width, im_height):
    bstr = ConstBitStream(filename=filename)
    boxes = [box for box in Parser.parse(bstr)]

    # skip 'free' box
    boxes = boxes[:1] + boxes[2:]

    ftyp = boxes[0]
    mdat = boxes[1]
    moov = boxes[2]

    # pop 'udta' box
    moov.boxes.pop()

    trak = moov.boxes[-1]

    # remove edts
    mdia = trak.pop()
    trak.pop()
    trak.append(mdia)

    for box in boxes:
        box.load(bstr)
        box.refresh_box_size()

    ftyp.major_brand = 1769172845           # b"isom"
    ftyp.minor_version = 0
    ftyp.compatible_brands = [1769172845]   # b"isom"
    ftyp.refresh_box_size()

    # moov.trak.mdia.minf.stbl
    stbl = moov.boxes[-1].boxes[-1].boxes[-1].boxes[-1]

    # moov.trak.mdia.minf.stbl.stsd.avc1
    avc1 = stbl.boxes[0].boxes[0]

    clap = bx_def.CLAP(BoxHeader())
    clap.header.type = b"clap"
    clap.clean_aperture_width_n = im_width
    clap.clean_aperture_width_d = 1
    clap.clean_aperture_height_n = im_height
    clap.clean_aperture_height_d = 1
    clap.horiz_off_n = im_width - 512
    clap.horiz_off_d = 2
    clap.vert_off_n = im_height - 512
    clap.vert_off_d = 2

    # insert clap before pasp
    pasp = avc1.pop()
    avc1.append(clap)
    avc1.append(pasp)

    stco = stbl.boxes[-1]
    stco.entries[0].chunk_offset = ftyp.header.box_size + mdat.header.header_size

    moov.refresh_box_size()

    return b''.join(bytes(box) for box in boxes)


parser = argparse.ArgumentParser()
parser.add_argument("input")
parser.add_argument("output")
parser.add_argument("image_width", type=int)
parser.add_argument("image_height", type=int)

args = parser.parse_args()

tuned_mp4_bytes = tune_video(args.input, args.image_width, args.image_height)

with open(args.output, "wb") as output:
    output.write(tuned_mp4_bytes)
