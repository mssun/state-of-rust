#!/bin/bash -e

pushd rust

# compiler features
rg ".*?\((active|removed|accepted),\s*(.*?),\s*\"(.*?)\",\s*(.*?),\s*(.*?)\)," -r '$1:$2:$3:$4:$5' -g '!src/test/*' --no-heading --line-number \
    | cut -d ':' -f1,2,3,4,5,6,7 --output-delimiter=' ' \
    | awk -v ORS='' '{print ""$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"; system("git --no-pager blame -L "$2","$2" -c  -- "$1" | cut -f3")}' \
    | uniq \
    | sort -k1,1 > compiler_feature_raw.txt

# stable library features or features will be stabilized in next few releases
rg ".*#\[stable\(feature\s*=\s*\"(.*?)\",.*since\s*=\s*\"(.*?)\"\)[,\]].*" -r '$1:$2' -g '!src/test/*' --no-heading --line-number \
    | cut -d ':' -f1,2,3,4 --output-delimiter=' ' \
    | awk -v ORS='' '{print ""$3"\t"$4"\t"; system("git --no-pager blame -L "$2","$2" -c  -- "$1" | cut -f3")}' \
    | uniq > stable_library_feature.txt

cat stable_library_feature.txt \
    | sort -u -k1,1 -k3,3 \
    | sort -u -k1,1 > stable_library_feature_first_commit.txt

cat stable_library_feature.txt \
    | sort -u -r -k1,1 -k3,3 \
    | sort -u -k1,1 > stable_library_feature_latest_commit.txt

# unstable library features which do not have ETA
rg ".*#\[unstable\(feature\s*=\s*\"(.*?)\",.*issue\s*=\s*\"(.*?)\"[,\)].*" -r '$1:$2' -g '!src/test/*' --no-heading --line-number \
    | cut -d ':' -f1,2,3,4 --output-delimiter=' ' \
    | awk -v ORS='' '{print ""$3"\t"$4"\t"; system("git --no-pager blame -L "$2","$2" -c  -- "$1" | cut -f3")}' \
    | uniq > unstable_library_feature.txt

cat unstable_library_feature.txt \
    | sort -u -k1,1 -k3,3 \
    | sort -u -k1,1 > unstable_library_feature_first_commit.txt

cat unstable_library_feature.txt \
    | sort -u -r -k1,1 -k3,3 \
    | sort -u -k1,1 > unstable_library_feature_latest_commit.txt

popd
