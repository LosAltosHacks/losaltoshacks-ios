#!/usr/bin/env python3
# Modified version of the script taken from:
# http://stackoverflow.com/questions/6428353/best-way-to-add-license-section-to-ios-settings-bundle

import os
import sys
import plistlib
import codecs
from copy import deepcopy

os.chdir(sys.path[0])

plist = {'PreferenceSpecifiers': [], 'StringsTable': 'Acknowledgements'}
base_group = {'Type': 'PSGroupSpecifier', 'FooterText': '', 'Title': ''}

base_path = '../Carthage/Checkouts'
for dirname in os.listdir(base_path):
    if dirname.endswith('.DS_Store'):
        continue
    for filename in os.listdir(base_path + '/' + dirname):
        if filename == 'LICENSE':
            path = base_path + '/' + dirname + '/' + filename
            file = codecs.open(path, 'r', 'utf-8')
            
            group = deepcopy(base_group)
            group['Title'] = dirname
            group['FooterText'] = file.read()
            
            plist['PreferenceSpecifiers'].append(group)

plistlib.writePlist(
    plist,
    './Settings.bundle/Acknowledgements.plist'
)
