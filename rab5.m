a=input('введите значения параметра а,  напоминание а =0.001:\n');
b=input('введите значение параметра b, напоминание b=-0.125:\n');
c=input('введите значение параметра с,  напоминание с=4.90:\n');
d=input('введите значение параметра d, напоминание  d=-30:\n');
t=input('введите значение параметра t, напоминание  d=0.01:\n');
x=0:t:30;
y=(a*(x.^3))+(b*(x.^2))+(c*x)+d;
plot(x, y,'g');
xlabel('ось х');
ylabel('ось y');
title(' график функции y(x)');
grid on;
filename = fopen('laba5.txt', 'w'); % Открытие файла для записи
if filename == -1
    error('Файл не открыт %s', 'laba5.txt');
end
fprintf(filename, ' a: %.3f\n b: %.3f\n c: %.3f\n d: %.3f\n t: %.2f\n', a, b, c, d, t);

fprintf(filename, '--------------------------------------------------------------\n');
fprintf(filename, '|%9s|%9s|%30s|%9s|\n','x','y','метод','скорость');
fprintf(filename, '--------------------------------------------------------------\n'); % Заголовок столбцов

while true
    n = input('введите номер метода: 1-метод половинного деления, 2- метод ложного положения\n');

    switch n
        case 1 
            [lx, ly, kol_iter1] = metod_pol(a, b, c, d);
            for i=1:length(lx)
                fprintf(filename, '|%9.3f|%9.3f|%30s|%9d|\n', lx(i), ly(i),'метод половинного деления' ,kol_iter1);
            end
        case 2
            [lx1, ly1, kol_iter2] = metod_log_nal(a, b, c, d);
            for j=1:length(ly1)
                fprintf(filename, '|%9.3f|%9.3f|%30s|%3d|\n', lx1(j), ly1(j),'метод ложного положения',kol_iter2);
            end
    end
    fprintf(filename, '--------------------------------------------------------------\n');
    
    konec = input('Закончить программу?(yes or no)\n', 's');
    if strcmpi(konec, 'yes') % функция позволяющая сравнить введенную строку со значением 'yes'
       clear
       clc
       close
       break;
    end
end
    

function [lx1,ly1,kol_iter2] = metod_log_nal(a,b,c,d)
    x1 = input('Введите начальную точку x1 (например, 0): ');
    x2 = input('Введите конечную точку x2 (например, 30): ');
    kol_iter2=0;
    e=0.01;
    t=0.01;
    lx1=[];
    ly1=[];
    y1=a.*x1.^3+b.*x1.^2+c.*x1+d;
    y2=a.*x2.^3+b.*x2.^2+c.*x2+d;
    iramasha = true;
    while iramasha
        xzv=x1-y1*(x2-x1)/(y2-y1);
        yzv=a.*xzv.^3+b.*xzv.^2+c.*xzv+d;
        lx1=[lx1,xzv];
        ly1=[ly1,yzv];
        if yzv*y1>0
            x1=xzv;
            y1=yzv;
        else
           x2=xzv;
           y2=yzv;
        end
        kol_iter2=kol_iter2+1;
        iramasha = (abs(yzv) > e);
    end
    disp(['Корень найден: ', num2str(xzv, 3)]);
    disp(['Значение функции в корне: ', num2str(yzv, 3)]);
    disp(['Количество итераций:',num2str(kol_iter2)]);
    disp(round(lx1,3));
    disp(round(ly1,3));
end


function [lx, ly, kol_iter1] = metod_pol(a,b,c,d)
    x1=input('Введите начальную точку:\n');
    x2=input('Введите конечную точку:\n');
    e=0.01;
    kol_iter1=0;
    lx=[];
    ly=[];

    fx1 = a * x1.^3 + b * x1.^2 + c * x1 + d;
    fx2 = a * x2.^3 + b * x2.^2 + c * x2 + d;

    condition = true;
    while condition
        k=(x2+x1)/2;
        lx=[lx,k];
        fk = a * k.^3 + b * k.^2 + c * k + d;
        if fk * fx1 > 0
            x1 = k;
            fx1 = fk;
            ly=[ly,fx1];
        else 
            x2 = k;
            fx2 = fk;
            ly=[ly,fx2];
        end
        kol_iter1 = kol_iter1 + 1;
        condition = (abs(fk) > e);
    end
    
    disp(['Ответ x=', num2str(k,2)]);
    disp(['Значение функции в x: ', num2str(fk, 3)]);
    disp(['Количество итераций:',num2str(kol_iter1)]);
    disp(round(lx,3));
    disp(round(ly,3));
end



    