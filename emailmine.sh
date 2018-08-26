#!/bin/bash
mkdir -p arraygen
cd arraygen
perl -MNet::FTP -e '$ftp = new Net::FTP("ftp.ncbi.nlm.nih.gov", Passive => 1);$ftp->login; $ftp->binary;$ftp->get("/entrez/entrezdirect/edirect.tar.gz");'
ls
gunzip -c edirect.tar.gz | tar xf -
ls
cd edirect
chmod a+x setup.sh
bash setup.sh
# Check Following MESSAGE: "Entrez Direct has been successfully downloaded and installed."
export PATH=$PATH:$(pwd)
esearch -db pubmed -query "9808944[JID]" | efetch -format MEDLINE | grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" | tee arraygen9808944.txt
# Further downstream Filtering and Extraction using "uniq" command and "ccTLD$" grep REGEX, Name arraygen file as per JID suffix.
