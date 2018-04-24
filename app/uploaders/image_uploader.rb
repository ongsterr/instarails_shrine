require "image_processing/mini_magick"

class ImageUploader < Shrine
    plugin :processing
    plugin :versions, names: [:original, :thumb, :medium] # enable Shrine to handle a hash of files
    plugin :delete_raw # delete processed files after uploading

    process(:store) do |io, context|
        original = io.download
        pipeline = ImageProcessing::MiniMagick.source(original) # What does this do?

        size_80 = pipeline.resize_to_limit!(80, 80)
        size_300 = pipeline.resize_to_limit!(300, 300)

        original.close! # Memory management - clear out of memory
        {original: io, thumb: size_80, medium: size_300} # Returns hash of the 3 sizes of same image

    end
end