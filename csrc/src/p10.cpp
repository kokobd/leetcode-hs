#include <string>

namespace leetcode::p10 {

class Token {

};

class Solution {
public:
    bool isMatch(const std::string &s, const std::string &p) {

    }
};

}

extern "C" bool p10_isMatch(const char *s, const char *p) {
    leetcode::p10::Solution solution;
    return solution.isMatch(std::string(s), std::string(p));
}

