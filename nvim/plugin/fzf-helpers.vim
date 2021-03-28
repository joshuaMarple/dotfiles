""" Get list of bookmarks (https://github.com/urbainvaes/fzf-marks)
command! Bookmarks call fzf#run(fzf#wrap({'source': 'cut -d: -f 2 ~/.fzf-marks | awk ''{$1=$1};1'''}))

""" Hg status in FZF
command! HgPstat call fzf#run(fzf#wrap({'source': 'hg pstatus -n'}))

""" Git status in FZF
command! GitStat call fzf#run(fzf#wrap({'source': 'git status -s | cut -c4-'}))

command! Ranger FloatermNew ranger

command! ProjectFiles execute 'Files' projectroot#guess()
command! GitDiff FloatermNew git diff

