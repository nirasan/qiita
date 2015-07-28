class EditRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  def self.make_patched_body(entry, edit_request)
    dmp = DiffMatchPatch.new
    diffs = self.diff_lineMode(edit_request.old_body, edit_request.body)
    patch = dmp.patch_make(edit_request.old_body, diffs)
    new_body, results = dmp.patch_apply(patch, entry.body)
    #binding.pry
    return new_body, results.all?{|result| result == true}
  end

  def self.apply_patched_body(entry, edit_request, new_body)
    entry.update(body: new_body) && edit_request.destroy
  end

  def self.diff_lineMode(text1, text2)
    dmp = DiffMatchPatch.new
    ary = dmp.diff_linesToChars(text1, text2)
    line_text1, line_text2, line_array = ary[0], ary[1], ary[2]
    diffs = dmp.diff_main(line_text1, line_text2, false)
    dmp.diff_charsToLines(diffs, line_array)
    return diffs
  end

  def self.create_premerged_body(entry, edit_request)
    new_body = ""
    self.diff_lineMode(entry.body, edit_request.body).each do |diff|
      case diff[0]
        when :equal then
          new_body += diff[1]
        when :insert then
          new_body += " <!-- 編集リクエスト:追記開始 --> \r\n" + diff[1] + " <!-- 編集リクエスト:追記終了 --> \r\n"
        when :delete then
          new_body += " <!-- 本文:更新開始 --> \r\n" + diff[1] + " <!-- 本文:更新終了 --> \r\n"
      end
    end
    new_body
  end
end
