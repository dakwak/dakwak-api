# Dakwak::Api

API wrapper in Ruby for dakwak API

## dakwak
  dakwak is a website translation and localization technology that helps businesses in going global by having up and running translated versions of their website with no technical involvement and no integration. 

  Translation quality is user-controlled through dakwak's multi-layered translation system offering machine, team, and professional translation options.

  Translated versions of the website run initially under a temporary subdomain provided by dakwak till the user configures his DNS and makes those versions run under his own domain name.

  Once the translated website is running under your own domain name, translated pages will start being indexed in search engines making your website visible to people searching in their native language.
  
  https://dakwak.com

## Installation

Add this line to your application's Gemfile:

    gem 'dakwak-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dakwak-api

## Usage
To start, create a wrapper and pass in your website's API key:

```ruby
wrapper = Dakwak::Api::Wrapper.new(APIKEY)
```

If you don't know your website's API key:
- Login to [dakwak](https://dakwak.com)
- Go to Dashboard -> My Website Content -> Settings
- Click on blue the button "Request API Key"

An email will be sent to the support staff at dakwak and they will contact you with your website’s API Key.


Next, you can use any of these methods on your wrapper object
### get_translation
```ruby
wrapper.get_translation(phrase, lang)
```

Returns the translation of a given phrase in the given language:

- It returns the published translation of a given term
- If no published translation was found, it returns the unpublished translation with the highest level
- If no unpublished translation was found, return an empty string
Example

```ruby
wrapper.get_translation("hola", "ar")
```

This says: get me the translation of hola in Arabic, and it will return a hash of the following:

```ruby
{"apikey"=>"1234567890abcdef", "lang"=>"ar", "phrase"=>"hola", "translation"=>"مرحبا"}
```

Note: If the phrase has not been translated before, you will get an error. In that case, you can use the translate() method to translate that phrase.

### translate
```ruby
wrapper.translate(phrase, lang, callback_url="")
```

Returns the translation of given phrases in the given language. If no translation was available for a certain phrase, it will do the following:
- If you provided a callback URL, it will translate the phrase & send the translation in a POST request to the callback URL
- If no callback URL was provided, it will still translate the phrase, but you have to send a request again to get the translation  

Example

```ruby
wrapper.translate(["hello", "welcome"], "ar")
```

This says: get me the translation of 'hello' and 'welcome' in Arabic, and it will return a hash of the following:
````ruby
{"apikey"=>"1234567890abcdef", "lang"=>"ar", "translation"=>{"hello"=>"مرحبا", "welcome"=>"ترحيب"}}
````

### search
```ruby
wrapper.search(phrase, lang)
```

Returns the phrases that match your query in the translated and the original versions of your website, along with the pages where these phrases were found.

Example

```ruby
wrapper.search("hola", "es")
```

This says: search through my Spanish website and original website for 'hola', and return URLs of pages where this phrase was found.

```ruby
{"apikey"=>"1234567890abcdef", "lang"=>"ar", "phrase"=>"welcome", "results"=>[
  {"source_text": "hello world","translated_text": "hola mundo","page_urls": ["/page1", "/page2"]}, 
  {"source_text": "hi","translated_text": "hola","page_urls": ["/page3", "/page4"]
}]
```

### index_pages
```ruby
wrapper.index_pages(pages)
```

This method basically indexes the pages you request. By indexing, we mean send a GET request to that page & therefor translating it.

Example

```ruby
wrapper.index_pages(["/page1", "/page2"])
```

Note: Indexing will happen as a background job, so it will not show any error messages if the indexing fails (returns 404, etc) 


### Notes:
- These methods assumes you have translated your website to the language of the phrase and the language requested. Otherwise you will get an error.
- the "lang" field of these methods accepts the shortcut version of the language, which are:

## Valid values for 'lang' field
<table border="1">
<thead>
<tr>
<td width="140">Language</td>
<td width="90">Shortcut</td>
<td width="140">Language</td>
<td width="90">Shortcut</td>
<td width="140">Language</td>
<td width="89">Shortcut</td>
</tr>
</thead>
<tbody>
<tr>
<td width="140">Afrikaans</td>
<td width="90">af</td>
<td width="140">Greek</td>
<td width="90">el</td>
<td width="140">Romanian</td>
<td width="89">ro</td>
</tr>
<tr>
<td width="140">Albanian</td>
<td width="90">sq</td>
<td width="140">Hebrew</td>
<td width="90">iw</td>
<td width="140">Russian</td>
<td width="89">ru</td>
</tr>
<tr>
<td width="140">Arabic</td>
<td width="90">ar</td>
<td width="140">Hindi</td>
<td width="90">hi</td>
<td width="140">Serbian</td>
<td width="89">sr</td>
</tr>
<tr>
<td width="140">Belarusian</td>
<td width="90">be</td>
<td width="140">Hungarian</td>
<td width="90">hu</td>
<td width="140">Slovak</td>
<td width="89">sk</td>
</tr>
<tr>
<td width="140">Bulgarian</td>
<td width="90">bg</td>
<td width="140">Icelandic</td>
<td width="90">is</td>
<td width="140">Slovenian</td>
<td width="89">sl</td>
</tr>
<tr>
<td width="140">Catalan</td>
<td width="90">ca</td>
<td width="140">Indonesian</td>
<td width="90">id</td>
<td width="140">Spanish</td>
<td width="89">es</td>
</tr>
<tr>
<td width="140">Chinese (Simplified)</td>
<td width="90">zh-CN</td>
<td width="140">Irish</td>
<td width="90">ga</td>
<td width="140">Swahili</td>
<td width="89">sw</td>
</tr>
<tr>
<td width="140">Croatian</td>
<td width="90">hr</td>
<td width="140">Italian</td>
<td width="90">it</td>
<td width="140">Swedish</td>
<td width="89">sv</td>
</tr>
<tr>
<td width="140">Czech</td>
<td width="90">cs</td>
<td width="140">Japanese</td>
<td width="90">ja</td>
<td width="140">Thai</td>
<td width="89">th</td>
</tr>
<tr>
<td width="140">Danish</td>
<td width="90">da</td>
<td width="140">Korean</td>
<td width="90">ko</td>
<td width="140">Turkish</td>
<td width="89">tr</td>
</tr>
<tr>
<td width="140">Dutch</td>
<td width="90">nl</td>
<td width="140">Latvian</td>
<td width="90">lv</td>
<td width="140">Ukrainian</td>
<td width="89">uk</td>
</tr>
<tr>
<td width="140">English</td>
<td width="90">en</td>
<td width="140">Lithuanian</td>
<td width="90">lt</td>
<td width="140">Vietnamese</td>
<td width="89">vi</td>
</tr>
<tr>
<td width="140">Estonian</td>
<td width="90">et</td>
<td width="140">Macedonian</td>
<td width="90">mk</td>
<td width="140">Welsh</td>
<td width="89">cy</td>
</tr>
<tr>
<td width="140">Filipino</td>
<td width="90">tl</td>
<td width="140">Malay</td>
<td width="90">ms</td>
<td width="140">Yiddish</td>
<td width="89">yi</td>
</tr>
<tr>
<td width="140">Finnish</td>
<td width="90">fi</td>
<td width="140">Maltese</td>
<td width="90">mt</td>
<td width="140">Urdu</td>
<td width="89">ur</td>
</tr>
<tr>
<td width="140">French</td>
<td width="90">fr</td>
<td width="140">Persian</td>
<td width="90">fa</td>
<td width="140">Chinese (Traditional)</td>
<td width="89">zh-TW</td>
</tr>
<tr>
<td width="140">Galician</td>
<td width="90">gl</td>
<td width="140">Polish</td>
<td width="90">pl</td>
<td width="140">French (Canada)</td>
<td width="89">fr-CA</td>
</tr>
<tr>
<td width="140">German</td>
<td width="90">de</td>
<td width="140">Portuguese (Europe)</td>
<td width="90">pt-PT</td>
<td width="140">Spanish (Latin America)</td>
<td width="89">es-LA</td>
</tr>
<tr>
<td width="140"></td>
<td width="90"></td>
<td width="140"></td>
<td width="90"></td>
<td width="140">Portuguese (Brazil)</td>
<td width="89">pt-BR</td>
</tr>
</tbody>
</table>
## Error Messages
Here's a list of error messages & more details about them:

- **invalid apikey:** your apikey is invalid, check you've copied and pasted it correctly.
- **website is locked:** one possible reason for this is that your trial was over and you haven't upgraded yet.
- **lang is not valid or supported:** the language you requested is not supported by dakwak.com or does not exist. Make sure to choose the correct language shortcut from the table above
- **lang is not included in your plan:** The language you chose is not included in your plan, please choose another language
- **phrase was not found:** the phrase was not found in the database, you can request a translation by using the translate() method

## Support
If you have questions or any inquries, please email info@dakwak.com
