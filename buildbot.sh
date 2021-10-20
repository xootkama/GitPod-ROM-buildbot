# Rom building script for CircleCI

MANIFEST_LINK=git://github.com/yaap/manifest.git
BRANCH=eleven
ROM_NAME=yaap
DEVICE_CODENAME=sdm710
GITHUB_USER=xootkama
GITHUB_EMAIL=xootkama@gmail.com
WORK_DIR=$(pwd)/${ROM_NAME}
JOBS=nproc

# Set up git!
git config --global user.name ${GITHUB_USER}
git config --global user.email ${GITHUB_EMAIL}

# make directories
mkdir ${WORK_DIR} && cd ${WORK_DIR}

# set up rom repo
repo init --depth=1 -u ${MANIFEST_LINK} -b ${BRANCH}
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j8

# clone device sources
git clone -b lineage-17.0 https://github.com/SagarMakhar/android_device_realme_sdm710-common.git device/realme/sdm710-common

git clone -b lineage-17.1 https://github.com/pjgowtham/kernel_realme_sdm710.git kernel/realme/sdm710 

git clone -b lineage-17.1 https://github.com/pjgowtham/vendor_realme_sdm710.git vendor/realme/sdm710

git clone -b giyarah https://github.com/xootkama/yaap_realme_RMX1851.git device/realme/RMX1851


# Start building!
. build/envsetup.sh
lunch yaap_sdm710-userdebug
mka bacon -j8

