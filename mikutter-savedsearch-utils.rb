

Plugin.create(:mikutter_savedsearch_utils) {

  # タブを閉じるボタンを追加する
  commands = Plugin.filtering(:command, {}).first

  begin
    options = commands[:saved_search_destroy].melt
    options[:icon] = Skin.get("close.png")

    command(:saved_search_destroy, options, &options[:exec])
  rescue => e
    puts e
    puts e.backtrace
  end

  # リロードボタンを追加する
  command(:saved_search_reload,
          name: '検索タブの更新',
          condition: lambda { |opt| opt.widget.slug =~ /savedsearch/ },
          icon: File.dirname(__FILE__) + "/playback_reload.png",
          visible: true,
          role: :tab) { |opt| 
    timeline = Plugin[:saved_search].timelines.values.find { |a| a.slug == opt.widget.slug }

    if timeline
      timeline(timeline[:slug]).clear
      Plugin[:saved_search].rewind_timeline(timeline)
    end
  }


# 壮大な計画
=begin
  on_gui_timeline_add_messages { |timeline, messages|
    check = false

    if messages.is_a?(Messages)
      if messages.count != 0
        check = true
      end
    else
      check = true
    end

    if check && (timeline.slug.to_s =~ /home/)
    end
  }
=end
}
