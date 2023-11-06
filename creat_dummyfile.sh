#!/bin/bash

# バケット名とファイル数を指定
BUCKET_NAME="your-bucket-name"
FILE_COUNT=10

# 指定した数のダミーファイルを作成してS3バケットにアップロード
for ((i=1; i<=FILE_COUNT; i++))
do
  FILE_NAME="dummyfile$i.txt"
  echo "This is dummy file $i" > $FILE_NAME
  aws s3 cp $FILE_NAME s3://$BUCKET_NAME/$FILE_NAME
  rm $FILE_NAME
done
