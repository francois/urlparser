%%{

machine url;

  # URL Parser Ragel Machine
  #
  # This machine will parse any URL you can throw at it, leaning towards a generic URL. This machine is intended to be used
  # from Ruby, Java, C, D and all other output languages Ragel supports. At the moment, only the Ruby and Java host languages
  # use this machine.
  #
  # This machine follows RFC 1738 (http://www.faqs.org/rfcs/rfc1738.html) very closely, reusing the same names for the different parts.

lowalpha      = ('a'..'z');
hialpha       = ('A'..'Z');
digits        = digit+;
alphadigit    = alpha | digit;

safe          = ('$' | '-' | '_' | '.' | '+');
extra         = ('!' | '*' "'" | '(' | ')' | ',');
national      = ('{' | '}' | '|' | '\\' | '^' | '~' | '[' | ']' | '`');
punctuation   = ('<' | '>' | '#' | '%' | '"');

reserved      = (';' | '/' | '?' | ':' | '@' | '&' | '=');
hex           = (digit | 'A'..'F' | 'a'..'f');
escape        = '%' hex hex;
unreserved    = alpha | digit | safe | extra;
uchar         = unreserved | escape;
xchar         = unreserved | reserved | escape;

toplabel      = alpha | ( alpha (alphadigit | '-')* alphadigit );
domainlabel   = alphadigit | ( alphadigit (alphadigit | '-')* ) alphadigit;
hostname      = ( domainlabel '.' )* toplabel;
hostnumber    = digits '.' digits '.' digits '.' digits;
host          = (hostname | hostnumber) >*begin_host %*host;
port          = digits >*begin_port %*port;
hostport      = host ( ':' port );
user          = ( uchar | ';' | '?' | '&' | '=' )* >begin_user %user;
password      = ( uchar | ';' | '?' | '&' | '=' )* >begin_password %password;

login         = ( user (':' password) '@' )? hostport;
urlpath       = (xchar*) >begin_path %path;

scheme        = (lowalpha | digit | '+' | '-' | '.')+ >begin_scheme %scheme;
ip_schemepart = '//' login ( '/' urlpath )?;
schemepart    = xchar* | ip_schemepart;

genericurl    = scheme ':' schemepart;
otherurl      = genericurl;

# url         = httpurl | ftpurl | newsurl | nttpurl | telneturl | gopherurl | waisurl | mailtourl | fileurl | properourl | otherurl;
url           = genericurl;

}%%
