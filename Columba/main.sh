#!/bin/bash


ip=$(ip a >> o && grep "inet " o >> p && awk '{print $2}' p |tail -1 >> a && awk -F '/' '{print $1}' a)
rm a o p

set hash=$(echo -n "Hello" | xxd -p)


