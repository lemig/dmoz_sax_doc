# DMOZ SAX Documents

This gem provides a StructureDocument and ContentDocument which are subclasses of the Nokogiri::XML::SAX::Document class and are intended to enable parse the content.rdf.u8 and structure.rdf.u8 files available on the dmoz.org page. This gem is not affiliated with the DMOZ project.

## Installation

Add this line to your application's Gemfile:

    gem 'dmoz_sax_doc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dmoz_sax_doc

## Usage

TODO: Write usage instructions here

## License

This gem makes use of snippets of the DMOZ RDF content available from dmoz.org as test files. DMOZ open directory project is [licensed](http://www.dmoz.org/license.html) under [Creative Commons Attribution 3.0 Unported](http://creativecommons.org/licenses/by/3.0/).

   <table>
     <tr align="center">
     <td>Help build the largest human-edited directory on the web.</td>
     </tr>
     <tr align="center">
     <td>
       <a href="/cgi-bin/add.cgi?where=Top">Submit a Site</a> -
       <a href="/about.html"><b>Open Directory Project</b></a> -
       <a href="/cgi-bin/apply.cgi?where=Top">Become an Editor</a>
     </td></tr>
   </table>


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
