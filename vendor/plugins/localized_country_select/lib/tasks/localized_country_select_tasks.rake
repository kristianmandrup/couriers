require 'rubygems'
require 'open-uri'

# Rake task for importing country names from Unicode.org's CLDR repository
# (http://www.unicode.org/cldr/data/charts/summary/root.html).
# 
# It parses a HTML file from Unicode.org for given locale and saves the 
# Rails' I18n hash in the plugin +locale+ directory
# 
# Don't forget to restart the application when you add new locale to load it into Rails!
# 
# == Example
#   rake import:country_select 'de'
# 
# The code is deliberately procedural and simple, so it's easily
# understandable by beginners as an introduction to Rake tasks power.
# See http://github.com/joshmh/cldr/tree/master/converter.rb for much more robust solution

namespace :import do

  desc "Import country codes and names for various languages from the Unicode.org CLDR archive. Depends on Hpricot gem."
  lang = ARGV.empty? ? 'lang' : ARGV[0].split(':').last
  task "country_select:#{lang}".to_sym do
    begin
      require 'hpricot'
    rescue LoadError
      puts "Error: Hpricot library required to use this task (import:country_select)"
      exit
    end

    # TODO : Implement locale import chooser from CLDR root via Highline

    # Check lang variable
    if lang == 'lang' || (/\A[a-z]{2}\z/).match(lang) == nil
      puts "\n[!] Usage: rake import:country_select:lang (Replace lang variable with language code you need.)\n\n"
      exit 0
    end

    # ----- Get the CLDR HTML     --------------------------------------------------
    begin
      puts "... getting the HTML file for locale '#{lang}'"
      doc = Hpricot( open("http://www.unicode.org/cldr/data/charts/summary/#{lang}.html") )
    rescue => e
      puts "[!] Invalid locale name '#{lang}'! Not found in CLDR (#{e})"
      exit 0
    end


    # ----- Parse the HTML with Hpricot     ----------------------------------------
    puts "... parsing the HTML file"
    countries = []
    doc.search("//tr").each do |row|
      if row.search("td[@class='n']") &&
         row.search("td[@class='n']").inner_html =~ /^namesterritory$/ &&
         row.search("td[@class='g']").inner_html =~ /^[A-Z]{2}/
        code   = row.search("td[@class='g']").inner_text
        code   = code[-code.size, 2]
        name   = row.search("td[@class='v']").inner_text
        countries << { :code => code.to_sym, :name => name.to_s }
        print " ... #{name}"
      end
    end


    # ----- Prepare the output format     ------------------------------------------
    output =<<HEAD
{ :#{lang} => {

    :countries => {
HEAD
    countries.each do |country|
      output << "\t\t\t:#{country[:code]} => \"#{country[:name]}\",\n"
    end
    output <<<<TAIL
    }

  }
}
TAIL


    # ----- Write the parsed values into file      ---------------------------------
    puts "\n... writing the output"
    filename = File.join(File.dirname(__FILE__), '..', 'locale', "#{lang}.rb")
    filename += '.NEW' if File.exists?(filename) # Append 'NEW' if file exists
    File.open(filename, 'w+') { |f| f << output }
    puts "\n---\nWritten values for the '#{lang}' into file: #{filename}\n"
    # ------------------------------------------------------------------------------
  end

end
