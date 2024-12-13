#include <iostream>
using namespace std;
int main() {
	system("chcp 1251");
	char a;
	int b, c;
	cout << "Введи знак действия \n";
	cin >> a;
	cout << "введи первое число \n";
	cin >> b;
	cout << "введите второе число \n";
	cin >> c;
	switch (a) {
	case '+': cout << "результат " << b + c << '\n';
		break;
	case '-': cout << "результат " << b - c << '\n';
		break;
	case '*': cout << "результат " << b * c << '\n';
		break;
	case '/': 
	
		if (a == '/' && c == 0) {
			cout << "так нельзя";
		}
		cout << "результат " << b / c << '\n';
		break;
	}
	system("pause");
	return 0;

}
