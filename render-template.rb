require 'mustache'
require 'yaml'
require 'pathname'

def replaceFileByItsContents(data, dataPath, dst)
    data.each { |k, v|
        if !v.is_a?(Hash) && !v.is_a?(Array)
            dst[k] = v
        elsif v.is_a?(Array)
            dst[k] = v.map { |elm|
                hs = Hash.new
                replaceFileByItsContents(elm, dataPath, hs)
                hs
            }
        elsif k == "file"
            dst[k] = Hash.new
            v.each { |fileKey, fileName|
                s = ""
                File.open(dataPath.join(fileName)) { |f|
                    f.each_line { |l|
                        s += l
                    }
                }
                dst[k][fileKey] = s
            }
        else
            dst[k] = Hash.new
            replaceFileByItsContents(v, dataPath, dst[k])
        end
    }
end

view = Mustache.new
view.template_file = ARGV[1]

yamlf = File.open(ARGV[0])
data = YAML.load(yamlf)
replaceFileByItsContents(data, Pathname(ARGV[0]).realpath.dirname, view)

print view.render