module Parser
  module PluginManager
    class Vimrc
      # vundle and vim-pathogen, and neobundle are special.
      # they might not be in .vimrc.
      def self.parse(line)
        case line
        when /^\s*call\s+vundle#rc()/
          "gmarik/vundle"
        when /^\s*call\s+pathogen#infect()/
          "tpope/vim-pathogen"
        when /^\s*call\s+neobundle#rc/
          "Shougo/neobundle.vim"
        # for github repo: git@github.com:SpringMT/unite-outline.git
        when /^\s*(Neo)?Bundle\s*["']git@github\.com\:(vim-scripts\/)?(.*?)(\.git)?["']/
          $3
        # for github repo: git://github.com/vim-scripts/neocomplcache.git
        when /^\s*(Neo)?Bundle\s*["'](https?|git):\/\/github\.com\/(vim-scripts\/)?(.*?)(\.git)?["']/
          $4
        # for non github repo: git://git.wincent.com/command-t.git
        when /^\s*(Neo)?Bundle\s*["'](https?|git):\/\/(.*?)["']/
          $3.sub(/\/$/, '') # remove trailing slash for svn repos
        # for ordinary vundle or neobundle url: Lokaltog/vim-easymotion
        when /^\s*(Neo)?Bundle\s*["'](vim-scripts\/)?(.*?)(\.git)?["']/
          $3
        else
          nil
        end
      end
    end
  end
end
