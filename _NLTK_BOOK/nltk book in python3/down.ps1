$base_url = "http://www.nltk.org/book/ch{0:d2}.html"
$base_fname = "Chapter{0:d2}.pdf"
for($i=0; $i -le 12; $i++){
    $url = [string]::Format($base_url,$i)
    $fname = [string]::Format($base_fname,$i)
    wkhtmltopdf $url $fname
}