#include "direct_mapped_cache.h"
#include "string"

#include <fstream>
#include <math.h>
#include <vector>

using namespace std;

string hexstr_to_binstr(int size, string hex)
{
    string bin;
    for (int i = hex.size() - 1; i >= 0; i--)
    {
        switch (hex[i])
        {
        case '0':
            bin.insert(0, "0000");
            break;
        case '1':
            bin.insert(0, "0001");
            break;
        case '2':
            bin.insert(0, "0010");
            break;
        case '3':
            bin.insert(0, "0011");
            break;
        case '4':
            bin.insert(0, "0100");
            break;
        case '5':
            bin.insert(0, "0101");
            break;
        case '6':
            bin.insert(0, "0110");
            break;
        case '7':
            bin.insert(0, "0111");
            break;
        case '8':
            bin.insert(0, "1000");
            break;
        case '9':
            bin.insert(0, "1001");
            break;
        case 'a':
            bin.insert(0, "1010");
            break;
        case 'b':
            bin.insert(0, "1011");
            break;
        case 'c':
            bin.insert(0, "1100");
            break;
        case 'd':
            bin.insert(0, "1101");
            break;
        case 'e':
            bin.insert(0, "1110");
            break;
        case 'f':
            bin.insert(0, "1111");
            break;
        default:
            break;
        }
    }
    while (bin.size() < size)
    {
        bin.insert(0, "0");
    }
    return bin;
}

long long binstr_to_decnum(string bin)
{
    long long dec = 0;
    for (int i = 0, p = bin.size() - 1; i < bin.size(); i++, p--)
    {
        if (bin[i] == '1') dec += (long long)pow(2, p);
    }
    return dec;
}

float direct_mapped(std::string filename, int block_size, int cache_size)
{
    int total_num = -1;
    int hit_num = 0;

    /* -------------------- */
    ifstream in;
    in.open(filename);

    total_num = 0;

    int offset_size, index_size, tag_size;
    offset_size = (int)log2(block_size);
    index_size = (int)log2(cache_size) - offset_size;
    tag_size = 32 - index_size - offset_size;

    /* | offset | index | tag | */

    string addr, address, offset, index, tag, tag_index;
    int block_num = cache_size / block_size;
    vector<string> cache(block_num);

    int block_addr, idx;

    while (in >> addr)
    {
        total_num++;

        address = hexstr_to_binstr(32, addr);
        offset = address.substr(0, offset_size);
        index = address.substr(offset_size, index_size);
        tag = address.substr(index_size, tag_size);

        block_addr = binstr_to_decnum(address) / block_size;
        idx = block_addr % block_num;

        if (cache[idx] == tag) hit_num++;
        else cache[idx] = tag;
    }

    cache.clear();
    in.close();
    /* -------------------- */

    return (float)hit_num / total_num;
}
