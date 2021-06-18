#!/bin/python
import os
import glob

files_dir = "../ansible/roles/install-jenkins-master/files/"

# parse file to - host : its_config_file_entry
all_config_files_info = open("{}all_nodes.xml".format(files_dir), "r").read()
all_config_files_info_splitted = all_config_files_info.split("||template_to_split_by||")
print(all_config_files_info)
config_files_dict = {hostname: config_info for hostname, config_info in [i.split("|template_to_split_by|") for i in all_config_files_info_splitted][1:]}

# delete old _config.xml files
for file in glob.glob(files_dir + "*_config.xml"):
    try:
        os.remove(file)
    except OSError:
        pass

# create config files for each node
for host, entry_ in config_files_dict.items():
    file = open(files_dir + "{}__config.xml".format(host), "w+")
    file.write(entry_)
    file.close()
