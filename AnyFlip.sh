#!/bin/bash
echo ""
echo "Recreate AnyFlip books"
echo ""
echo "This script is provided for free and as is, however if it's useful to you I'm happy to take donations via"
echo "https://cash.app/%C2%A3MessGir or https://ko-fi.com/heather_herbert"
echo ""
read -p "Enter the books path (i.e. lszgs/jhra) " pathid
read -p "Enter the books page count " pagecount
read -p "Start? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

PDFS=""

URL="https://online.anyflip.com/${pathid}/files/mobile/"

for (( COUNT=1; COUNT<pagecount; ++COUNT)); do
    wget "${URL}${COUNT}.jpg" --no-check-certificate
    sleep 1.5s
    PDFS="${PDFS} ${COUNT}.pdf"
done
rename 'unless (/0+[0-9]{3}.jpg/) {s/^([0-9]{1,2}\.jpg)$/00$1/g;s/0*([0-9]{3}\..*)/$1/}' *
img2pdf *.jpg --auto-orient --output combined.pdf
