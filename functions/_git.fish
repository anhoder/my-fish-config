function _git
    set --local git_unstaged_dirty_symbol ''
    set --local git_uncommited_dirty_symbol ''
    set --local git_dirty_color ''
    set --local git_branch_color ''

    set --local git_branch (
        command git symbolic-ref --short HEAD 2>/dev/null
        or command git name-rev --name-only HEAD 2>/dev/null
    )

    if test -n "$git_branch"
        set git_branch " $git_branch"
        set git_branch_color (set_color purple)
    end

    set --local git_unstaged_is_dirty (
        not command git diff --ignore-submodules --no-ext-diff --quiet --exit-code >/dev/null 2>&1
        and echo 'true'
    )
    set --local git_uncommited_is_dirty (
        not command git diff-index --ignore-submodules --cached --quiet HEAD -- >/dev/null 2>&1
        and echo 'true'
    )
    if test -n "$git_unstaged_is_dirty"
        set git_unstaged_dirty_symbol '*'
        set git_dirty_color (set_color red)
    end
    if test -n "$git_uncommited_is_dirty"
        set git_uncommited_dirty_symbol '+'
        set git_dirty_color (set_color red)
    end

    set --local normal_color (set_color normal)

    echo $normal_color'['$git_branch_color$git_branch$git_dirty_color$git_uncommited_dirty_symbol$git_unstaged_dirty_symbol$normal_color']'
end