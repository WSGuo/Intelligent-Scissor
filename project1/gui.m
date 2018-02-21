function gui
% SIMPLE_GUI2 Select a data set from the pop-up menu, then
% click one of the plot-type push buttons. Clicking the button
% plots the selected data in the axes.

   %  Create and then hide the UI as it is being constructed.
   f = figure('Visible','off','Position',[360,500,450,285]);
   
   %  Construct the components.
   File = uimenu(f,'Label','File');
   Open = uimenu(File,'Label','Open');
   Save = uimenu(File,'Label','Save');
   
   
   % Make the UI visible.
   f.Visible = 'on';
   f.MenuBar = 'none';

end