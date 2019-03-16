#define LOCAL

#ifdef LOCAL
namespace leetcode::p21 {

struct ListNode {
    int val;
    ListNode *next;
    explicit ListNode(int x) : val(x), next(nullptr) {}
};

#endif

class Solution {
public:
    ListNode *mergeTwoLists(ListNode *l1, ListNode *l2) {
        ListNode *l3 = nullptr;
        ListNode *l3Last = nullptr;

        while (!(l1 == nullptr && l2 == nullptr)) {
            ListNode *&min = l1 == nullptr
                             ? l2 : (l2 == nullptr
                                     ? l1 : (l1->val < l2->val ? l1 : l2));
            if (l3 == nullptr) {
                l3 = min;
                l3Last = min;
            } else {
                l3Last->next = min;
                l3Last = min;
            }
            min = min->next;
        }
        return l3;
    }
};

#ifdef LOCAL
}
#endif
