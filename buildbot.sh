# Rom building script for CircleCI
# coded by bruh™ aka Live0verfl0w

MANIFEST_LINK=git://github.com/ProjectSakura/android.git
BRANCH=10
ROM_NAME=lineage
DEVICE_CODENAME=dreamlte
GITHUB_USER=Exynos-nigg
GITHUB_EMAIL=vsht700@gmail.com
WORK_DIR=$(pwd)/${ROM_NAME}
JOBS=nproc

# Set up git!
git config --global user.name ${GITHUB_USER}
git config --global user.email ${GITHUB_EMAIL}

# make directories
mkdir ${WORK_DIR} && cd ${WORK_DIR}

# set up rom repo
repo init --depth=1 -u ${MANIFEST_LINK} -b ${BRANCH}
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j${JOBS}

# clone device sources
git clone -b lineage-17.1 https://github.com/Sakura-Devices/device_samsung_dreamlte.git device/samsung/dreamlte 

git clone -b lineage-17.1 https://github.com/Sakura-Devices/device_samsung_universal8895-common.git device/samsung/universal8895-common 

git clone -b pie https://github.com/Sakura-Devices/kernel_samsung_universal8895.git kernel/samsung/universal8895 

git clone -b lineage-17.1 https://github.com/Sakura-Devices/vendor_samsung_dreamlte.git vendor/samsung/dreamlte 

git clone -b lineage-17.1 https://github.com/Sakura-Devices/vendor_samsung_universal8895-common.git vendor/samsung/universal8895-common 

git clone -b lineage-17.1 https://github.com/LineageOS/android_hardware_samsung.git hardware/samsung

# Start building!
. build/envsetup.sh
lunch lineage_${DEVICE_CODENAME}-userdebug
mka bacon -j${JOBS}

