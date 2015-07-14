#ifndef __Settings__
#define __Settings__

#include <iostream>
#include <string>
#include <Foundation/Foundation.h>

extern const char *path;
extern NSMutableDictionary *prefs;
#define S(p) const char* path = p; Settings

using namespace std;

class Settings {
public:

    static int GetPrefInt(const char* key);
    static float GetPrefFloat(const char* key);
    static bool GetPrefBool(const char* key);

    __attribute__((noinline))
    bool reloadSettings();

    class settings_proxy {
    public:
        char* key;

        union Value {
            int asInt;
            bool asBool;
            float asFloat;
        } value;

        enum ValueType {
            Int,
            Bool,
            Float
        } valueType;

        settings_proxy(const char* _key) {
            key = (char*)malloc(strlen(_key));
            strcpy(key, _key);
        }

        settings_proxy(int val) {
            value.asInt = val;
            valueType = Int;
        }

        settings_proxy(float val) {
            value.asFloat = val;
            valueType = Float;
        }

        settings_proxy(bool val) {
            value.asBool = val;
            valueType = Bool;
        }


        __attribute__((noinline))
        operator int() {
            return Settings::GetPrefInt(key);
        }

        __attribute__((noinline))
        operator float() {
            return Settings::GetPrefFloat(key);
        }

        __attribute__((noinline))
        operator bool() {
            return Settings::GetPrefBool(key);
        }

        __attribute__((noinline))
        settings_proxy& operator= (const settings_proxy &source) {
            switch(source.valueType)
            {
                case Int: {
                    set(source.value.asInt);
                    break;
                }
                case Bool: {
                    set(source.value.asBool);
                    break;
                }
                case Float: {
                    set(source.value.asFloat);
                    break;
                }
            }
            return *this;
        }
        void set(bool value);
        void set(int value);
        void set(float value);

        __attribute__((noinline))
        ~settings_proxy() {
            if (key != NULL)
                free(key);
        }
    };
    __attribute__((noinline))
    settings_proxy operator[] (const char* key) {
        settings_proxy proxy(key);
        return proxy;
    }

};

extern Settings settings;
#endif
