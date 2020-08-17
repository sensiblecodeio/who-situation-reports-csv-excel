#!/bin/sh -eu
# Usage ./convert.sh <WHO Situation Report URL 1> <WHO Situation Report URL 2> …
for u in "$@"; do
    curl -JLO "$u"
done

for f in *.pdf; do
    [ -f "$f" ]
    curl -F f=@"$f" "https://pdftables.com/api?key=$PDFTABLES_API_KEY&format=csv" > "./csv/$(basename -s .pdf "$f").csv"
    curl -F f=@"$f" "https://pdftables.com/api?key=$PDFTABLES_API_KEY&format=xlsx-multiple" > "./xlsx/$(basename -s .pdf "$f").xlsx"
    rm "$f"
done
