ID=${PRODUCT_NAME}

FOR_SIMULATOR_DIR=${TARGET_BUILD_DIR}/../Debug-iphonesimulator/${ID}.framework
FOR_DEVICE_DIR=${TARGET_BUILD_DIR}/../Debug-iphoneos/${ID}.framework

FOR_SIMULATOR=${FOR_SIMULATOR_DIR}/${ID}
FOR_DEVICE=${FOR_DEVICE_DIR}/${ID}

FOR_BOTH_PARENT_DIR=..
FOR_BOTH_DIR=${FOR_BOTH_PARENT_DIR}/${ID}.framework
FOR_BOTH=${FOR_BOTH_PARENT_DIR}/${ID}.framework/${ID}


echo "FOR_SIMULATOR -> "${FOR_SIMULATOR}
echo "FOR_DEVICE -> "${FOR_DEVICE}
echo "FOR_BOTH_DIR -> "${FOR_BOTH_DIR}
echo "FOR_BOTH -> "${FOR_BOTH}
echo "HEADERS_DIR -> "${HEADERS_DIR}

if [ -f $FOR_SIMULATOR ];then
if [ -f $FOR_DEVICE ];then
if [ -d $FOR_BOTH_DIR ];then
rm -r $FOR_BOTH_DIR
fi

mkdir $FOR_BOTH_DIR
cp -r $FOR_SIMULATOR_DIR ${FOR_BOTH_PARENT_DIR}
cp -r $FOR_DEVICE_DIR ${FOR_BOTH_PARENT_DIR}
lipo -create ${FOR_SIMULATOR} ${FOR_DEVICE} -output ${FOR_BOTH}

fi
fi
