#define LOCAL

#ifdef LOCAL
namespace leetcode::p19 {

struct ListNode {
    int val;
    ListNode *next;
    explicit ListNode(int x) : val(x), next(nullptr) {}
};
#endif

class Solution {
public:
    ListNode *removeNthFromEnd(ListNode *head, int n) {
        ListNode *p1 = head;
        ListNode *p2 = head;
        int pDist = 0;
        while (p2->next != nullptr) {
            if (pDist < n) {
                p2 = p2->next;
                ++pDist;
            } else { // pDist == n
                p1 = p1->next;
                p2 = p2->next;
            }
        }
        if (pDist < n) {
            return p1->next;
        } else {
            ListNode *next = p1->next;
            p1->next = next->next;
            return head;
        }
    }
};

#ifdef LOCAL
}
#endif

