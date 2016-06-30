class XmlDocument
    # TODO: your code goes here!
    def initialize (indent=false)
        @indent = indent
        @times_indent = ""
    end
    
    def method_missing(method_name, options = {}, &block)
        method_name = method_name.to_s
        if !@indent
            if block_given?
                tag =  "<#{method_name}>" + block.call + "</#{method_name}>"
            else
                if options.length == 0
                    tag = "<#{method_name}/>"
                else
                    i = 0
                    while i < options.length
                        tag = "<#{method_name}" + " #{options.keys[i]}=\"#{options.values[i]}\"" + "/>"
                        i += 1
                    end
                    tag
                end
            end
        else
            if block_given?
                closing_tag = @times_indent + "</#{method_name}>\n"
                @times_indent += "  "
                opening_tag =  "<#{method_name}>\n" + @times_indent + block.call
                opening_tag + closing_tag
            else
                if options.length == 0
                    tag = "<#{method_name}/>\n"
                else
                    i = 0
                    while i < options.length
                        tag = "<#{method_name}" + " #{options.keys[i]}=\"#{options.values[i]}\"" + "/>\n"
                        i += 1
                    end
                    tag
                end
            end
        end
    end
end