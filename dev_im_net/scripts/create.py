import os, tarfile

with tarfile.open("imagenet/ILSVRC2012_img_train.tar", 'r') as tar, \
     tarfile.open("dev_im_net.tar", 'w') as dev_tar:
    for i, member in enumerate(tar):
        if i >= 12:
            break
    
        with tarfile.open(fileobj=tar.extractfile(member), mode="r") as sub_tar, \
             tarfile.open(member.name, "w") as dev_sub_tar:
            for j, sub_member in enumerate(sub_tar):
                if j >= 10:
                    break

                sub_tar.extract(sub_member)
                dev_sub_tar.add(sub_member.name)
                os.remove(sub_member.name)
                print(member.name, sub_member.name)

        dev_tar.add(member.name)
        os.remove(member.name)

