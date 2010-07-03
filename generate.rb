#!/usr/bin/env ruby

require 'erb'
require 'fileutils'
require 'yaml'

FileUtils.cd( File.dirname(__FILE__) )

config = YAML.load( File.read("config.yaml") )
$binding = binding

contents = File.join( config['name']+".app", "Contents" )
resources = File.join( contents, "Resources" )
english = File.join( resources, "English.lproj" )
macos = File.join( contents, "MacOS" )


def parse_erb( dest )
  src = File.join( "erb", File.basename(dest)+".erb" )
  FileUtils.mkdir_p( File.dirname(dest) )
  File.open( dest, "w" ){ |f|
    f << ERB.new( File.read(src), nil, "%" ).result( $binding )
  }
end

parse_erb  File.join( contents, "Info.plist" )
parse_erb  File.join( english, "MainMenu.xib" )
parse_erb  File.join( macos, "run.sh" )
