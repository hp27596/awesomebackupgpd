#!/bin/sh

# Get synonym of input word

word=$(echo "" | dmenu -i -p 'Synonym:') && qutebrowser --target window thesaurus.com/browse/$word
