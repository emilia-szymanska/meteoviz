#ifndef URL_CONNECTION_H
#define URL_CONNECTION_H

#include <iostream>
#include <string>
#include <curl/curl.h>
//#include <jsoncpp/json/json.h>

class UrlConnection
{
    std::string urlAddress;
    public:
        UrlConnection();
        UrlConnection(std::string address);
};

#endif // URL_CONNECTION_H
