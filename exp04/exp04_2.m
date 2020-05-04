% Exp04-2
% Author: Qin Hao
% Date: 2020/5/4

%------TestĿ¼����ͼ��boardWithNoise.jpg����Matlabд���򣬲�������Ӧ��ֵ�˲���ȥ���������š�------

% ����Ӧ��ֵ�˲��������һ�����趨�����ı��˴��Ĵ�С,������������ϴ�ʱ,ͨ�������˴��Ĵ�С����������ȥ��,
% ͬʱ���ж��˴����ĵ����ز�������ʱ,���ı��䵱ǰ����ֵ,��������ֵ���档

% ����,����Ӧ��ֵ�˲������Դ����������ʸ������������,
% ͬʱ��ƽ������������ͼ��ʱ�ܹ����õر���ͼ��ϸ��,���Ǵ�ͳ��ֵ�˲�����������

% ����ԭʼͼ��
img = imread('test/boardWithNoise.jpg');
% ת��Ϊ�Ҷ�ͼƬ
g = rgb2gray(img);
f = g;
f(:) = 0;
been = false(size(g)); % �Ѿ�������ĵط�
Smax = 325; % Sxy ����������ֵ, boardWithNoise.jpg ��СΪ 325 * 325
for i = 3 : 2 : Smax
    Zmin = ordfilt2(g, 1, ones(i, i), 'symmetric'); % Zmin ����Sxy�˴��ڻҶȵ���Сֵ
    Zmax = ordfilt2(g, i * i, ones(i, i), 'symmetric'); % Zmax ����Sxy�˴��ڻҶȵ����ֵ
    Zmed = medfilt2(g, [i i], 'symmetric'); % Zmed ����Sxy�˴��ڻҶȵ���ֵ

    prolevelB = (Zmed > Zmin) & (Zmax > Zmed) & ~been; % ��Ҫת��B���������
    zb = (g > Zmin) & (Zmax > g);

    outZxy = prolevelB & zb; % ���㲽��A��B�����ԭֵ
    outZmed = prolevelB & ~zb; % ����A,������B�������ֵ

    f(outZxy) = g(outZxy);
    f(outZmed) = Zmed(outZmed);

    been = been | prolevelB;
    if all(been(:))
        break;
    end
end
f(~been) = g(~been); % �������ڴ�Сû�����������λ�����ԭֵ

% ��ʾԭʼͼ��
figure, subplot(1, 2, 1), imshow(img);
title("ԭʼͼ��");
% ��ʾ����Ӧ��ֵ�˲�ͼ��
subplot(1, 2, 2), imshow(f);
title("����Ӧ��ֵ�˲�ͼ��");