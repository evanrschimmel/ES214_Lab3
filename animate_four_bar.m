function animate_four_bar(xA, yA, xB, yB, xC, yC, LOD)

%==========================================================================
%
%  Create an animation of a four-bar linkage system consisting of two
%  links and a triangular plate.
%
%==========================================================================
%
%  Initialize the animation figure window.
%
%--------------------------------------------------------------------------

%  Determine appropriate axes limits based on the range of motion:

xmin = min([0, min(xA)]);
xmax = max([LOD, max(xB)]);
xpad = 0.1*(xmax - xmin);

ymin = min([min(yA), min(yB), min(yC)]);
ymax = max([max(yA), max(yB), max(yC)]);
ypad = 0.1*(ymax - ymin);

%--------------------------------------------------------------------------

%  Set up the figure window for animation:

figure
set(gcf, 'color', 'w')
plot(0, 0, 'color','k', 'marker', 'o', 'markersize', 8, 'markerfacecolor', 'k');
hold on
plot(LOD, 0, 'color', 'k', 'marker', 'o', 'markersize', 8, 'markerfacecolor', 'k');
xlabel('Horizontal position (mm)')
ylabel('Vertical position (mm)')
axis equal
xlim([xmin - xpad, xmax + xpad])
ylim([ymin - ypad, ymax + ypad])

%--------------------------------------------------------------------------
%
%  Draw the four-bar linkage system.
%
%--------------------------------------------------------------------------

%  Draw the links OA and BD:

link_OA = line('xdata', [0, xA(1)], 'ydata', [0, yA(1)], 'color', 'k', 'linewidth', 2);
link_BD = line('xdata', [LOD, xB(1)], 'ydata', [0, yB(1)], 'color', 'k', 'linewidth', 2);

%--------------------------------------------------------------------------

%  Draw the triangular plate ABC:

plate_ABC = patch('xdata', [xA(1), xB(1), xC(1)], 'ydata', [yA(1), yB(1), yC(1)], ...
                  'edgecolor', 'k', 'linewidth', 2, 'facecolor', 0.8*[1, 1, 1], 'facealpha', 0.5);

%--------------------------------------------------------------------------

%  Draw the points A, B, and C:

point_A = line('xdata', xA(1), 'ydata', yA(1), 'color', 'r', 'marker', 'o', 'markersize', 8, 'markerfacecolor', 'r');
point_B = line('xdata', xB(1), 'ydata', yB(1), 'color', 'b', 'marker', 'o', 'markersize', 8, 'markerfacecolor', 'b');
point_C = line('xdata', xC(1), 'ydata', yC(1), 'color', [0, 0.5, 0], 'marker', 'o', 'markersize', 8, 'markerfacecolor', [0, 0.5, 0]);

%--------------------------------------------------------------------------

%  Trace out the paths of points A, B, and C:

point_A_path = animatedline('color', 'r', 'linewidth', 1);
point_B_path = animatedline('color', 'b', 'linewidth', 1);
point_C_path = animatedline('color', [0, 0.5, 0], 'linewidth', 1);
           
%--------------------------------------------------------------------------
%
%  Animate the four-bar linkage's motion by updating the figure with the
%  current positions of points A, B, and C.
%
%--------------------------------------------------------------------------

for k = 1:length(xA)
    set(plate_ABC, 'xdata', [xA(k), xB(k), xC(k)], 'ydata', [yA(k), yB(k), yC(k)]);
    set(link_OA, 'xdata', [0, xA(k)], 'ydata', [0, yA(k)]);
    set(link_BD, 'xdata', [LOD, xB(k)], 'ydata', [0, yB(k)]);
    set(point_A, 'xdata', xA(k), 'ydata', yA(k));
    set(point_B, 'xdata', xB(k), 'ydata', yB(k));
    set(point_C, 'xdata', xC(k), 'ydata', yC(k));
    addpoints(point_A_path, xA(k), yA(k));
    addpoints(point_B_path, xB(k), yB(k));
    addpoints(point_C_path, xC(k), yC(k));
    drawnow
end

%==========================================================================

end