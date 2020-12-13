#include <iostream>
#include <vector>
#include <string>
#include <thread>
#include <mutex>
#include <chrono>
using namespace std;

int N;
int M;

class semaphore {
private:
    mutex m;
    int v;
public:
    int getV() { return v; }
    semaphore(int val = 0) {
        v = val;
    }
    void post() {
        m.lock();
        v++;
        m.unlock();
    }
    void wait() {
        while (1) {
            m.lock();
            if (v > 0) {
                --v;
                m.unlock();
                return;
            }
            m.unlock();
        }
    }
    bool isEmpty() { return v == 0; }
};

bool check(string line) {
    for (int i = 0; i < line.length(); i++)
        if (line[i] < '0' || line[i] > '9')
            return false;
    return true;
}

semaphore s(0);

void cook() {
    cout << "The cooking has started" << endl;
    for (int i = 0; i < M; i++)
        s.post();
    cout << "Done cooking\t" << s.getV() << endl;
}

void eat(int i) {
    if (s.isEmpty())
        cook();
    cout << "Cannbial number " + to_string(i) + " has started eating\t" << endl;
    s.wait();
    cout << "Cannbial number " + to_string(i) + " has finished eating\t" << endl;
}


int main(int argc, char* argv[]) {
    if (argc != 3) {
        cout << "The first argument has to be N, the second one has to be M" << endl;
        return 0;
    }

    if (!check(argv[1]) || !check(argv[2])) {
        cout << "N and M have to be natural numbers" << endl;
        return 0;
    }

    N = stoi(argv[1]);
    M = stoi(argv[2]);
    for (int i = 0; i < N; i++) {
        thread t(eat, i);
        t.join();
    }
    return 0;
}