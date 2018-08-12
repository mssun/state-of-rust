#!/bin/bash -e

git clone https://github.com/rust-lang/rust.git

pushd rust

# stable features or features will be stabilized in next few releases
rg ".*#\[stable\(feature\s*=\s*\"(.*?)\",.*since\s*=\s*\"(.*?)\"\)[,\]].*" -r '$1:$2' -g '!src/test/*' --no-heading --line-number \
    | cut -d ':' -f1,2,3,4 --output-delimiter=' ' \
    | awk -v ORS='' '{print ""$3"\t"$4"\t"; system("git --no-pager blame -L "$2","$2" -c  -- "$1" | cut -f3")}' \
    | uniq > stable_feature.txt

cat stable_feature.txt \
    | sort -u -k1,1 -k3,3 \
    | sort -u -k1,1 > stable_feature_first_commit.txt

cat stable_feature.txt \
    | sort -u -r -k1,1 -k3,3 \
    | sort -u -k1,1 > stable_feature_latest_commit.txt

cat stable_feature_latest_commit.txt | cut -f3 > stable_feature_latest_commit_time.txt
paste stable_feature_latest_commit.txt stable_feature_latest_commit_time.txt | sort -V -k2,2 -k3,3 -k4,4 | column -t -s $'\t' -n

# unstable features which do not have ETA
rg ".*#\[unstable\(feature\s*=\s*\"(.*?)\",.*issue\s*=\s*\"(.*?)\"[,\)].*" -r '$1:$2' -g '!src/test/*' --no-heading --line-number \
    | cut -d ':' -f1,2,3,4 --output-delimiter=' ' \
    | awk -v ORS='' '{print ""$3"\t"$4"\t"; system("git --no-pager blame -L "$2","$2" -c  -- "$1" | cut -f3")}' \
    | uniq > unstable_feature.txt

cat unstable_feature.txt \
    | sort -u -k1,1 -k3,3 \
    | sort -u -k1,1 > unstable_feature_first_commit.txt
cat unstable_feature.txt \
    | sort -u -r -k1,1 -k3,3 \
    | sort -u -k1,1 > unstable_feature_latest_commit.txt

cat unstable_feature_latest_commit.txt | cut -f3 > unstable_feature_latest_commit_time.txt
paste unstable_feature_latest_commit.txt unstable_feature_latest_commit_time.txt | sort -k3,3 -k4,4 | column -t -s $'\t' -n

popd
