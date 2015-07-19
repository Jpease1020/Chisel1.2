# read in the file contents from the markdown file (any file) and save it somewhere
# convert it to html
# print converted html into a new file called my_output.html (be able to make any file)
# print summary to the screen


# here is the commnad line command
# $ ruby ./lib/chisel.rb my_input.markdown my_output.html
# Converted my_input.markdown (6 lines) to my_output.html (8 lines)


markdown_text = File.read(ARGV[0])

puts markdown_text
