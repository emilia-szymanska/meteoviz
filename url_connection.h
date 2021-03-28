#ifndef URL_CONNECTION_H
#define URL_CONNECTION_H

#include <iostream>
#include <string>
#include <curl/curl.h>

class UrlConnection
{
    string urlAddress;
    public:
        UrlConnection();
        UrlConnection(string address);
};

#endif // URL_CONNECTION_H
