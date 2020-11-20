#!/usr/bin/python3
# -*- coding: utf-8 -*-

import sys
from urllib.request import urlopen
import json
import os
from os.path import join, isfile
import subprocess
from shutil import copy, move
import stat
import codecs

def get_download_url(latest_manifest, latest_version):
    for version in latest_manifest['versions']:
        if version['id'] == latest_version:
            meta_url = version['url']
            meta_json = json.load(urlopen(meta_url))
            return meta_json['downloads']['server']['url']


def update_if_changed(latest_manifest, latest_version):
    latest_file = '/etc/minecraft/bin/minecraft_server.%s.jar' % (latest_version)
    if isfile(latest_file):
        #print('file exists')
        pass
    else:
        server_url = get_download_url(latest_manifest, latest_version)
        #print('downloading: %s from %s\n' % (latest_file, server_url))
        CHUNK = 16 * 1024
        jar_data = urlopen(server_url)
        with open(latest_file, 'wb') as outfile:
            while True:
                chunk = jar_data.read(CHUNK)
                if not chunk:
                    break
                outfile.write(chunk)
        server_link = '/etc/minecraft/bin/minecraft_server.jar'
        if isfile(server_link):
            os.remove(server_link)
        os.symlink(latest_file, server_link)

def main(argv):
    response = urlopen('https://launchermeta.mojang.com/mc/game/version_manifest.json')
    latest_manifest = json.load(response)
    latest_version = latest_manifest["latest"]["release"]
    #print('latest version %s' % latest_version)
    update_if_changed(latest_manifest, latest_version)

if __name__ == "__main__":
    __file__ = sys.argv[0]
    sys.exit( main(sys.argv) )
