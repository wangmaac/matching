import os

org = "com.wangmaac"
name = "matching"
cmd = "flutter create --org " + org + " --project-name " + name + " .";
packages = [
 "go_router",
 "provider",
 "freezed_annotation",
 "http",
 "flutter_native_splash",
 "intl",
 "google_fonts"
];

for p in packages:
	cmd += " && flutter pub add " + packages[packages.index(p)]

packages = [
 "build_runner",
 "freezed",
 "json_serializable", 
];

for p in packages: 
	cmd += " && flutter pub add " + packages[packages.index(p)]


cmd += " && mkdir images";
cmd += " && cd lib";
cmd += " && mkdir application";
cmd += " && mkdir model";
cmd += " && mkdir view";
cmd += " && mkdir repository";
cmd += " && mkdir view_model";

# Create project
os.system(cmd);

# Replace main file
main = """import 'package:flutter/material.dart';

void main() => runApp(const Application());

"""

mainPath = "lib/main.dart"; 
os.remove(mainPath);
f = open(mainPath, "a")
f.write(main)
f.close()
