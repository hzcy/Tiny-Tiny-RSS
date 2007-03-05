#!/bin/sh
TEMPLATE=messages.pot

xgettext -kT_sprintf -kT_ngettext:1,2 -k__ -L PHP -o $TEMPLATE *.php modules/*.php

update_lang() {
	if [ -f $1.po ]; then
		TMPFILE=/tmp/update-translations.$$
	
		msgmerge -o $TMPFILE $1.po $TEMPLATE
		mv $TMPFILE $1.po
		msgfmt --statistics $1.po
		msgfmt -o $1.mo $1.po
	else
		echo "Usage: $0 [-p|<basename>]"
	fi
}

LANGS=`find locale -name 'messages.po'`

for lang in $LANGS; do
	echo Updating $lang...
	PO_BASENAME=`echo $lang | sed s/.po//`
	update_lang $PO_BASENAME
done