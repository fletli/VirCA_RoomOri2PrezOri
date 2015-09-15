function roomQuat2YPR(filename)	
  disp('Parsing...');
  DOMnode = xmlread(filename);
  disp(DOMnode);
  allQuats = DOMnode.getElementsByTagName('quaternion');
  
  NodesToDelete = [];
  

  for k = 0:allQuats.getLength-1
   thisQuat = allQuats.item(k).getChildNodes();
   NodesToDelete = [NodesToDelete, thisQuat];
   
   X = str2double(thisQuat.item(1).getTextContent())
   Y = str2double(thisQuat.item(3).getTextContent())
   Z = str2double(thisQuat.item(5).getTextContent())
   W = str2double(thisQuat.item(7).getTextContent())
   
   Q = [W X Y Z]
   [Yaw, Pitch, Roll] = quat2angle(Q, 'YXZ');
  
   WhereToAdd=allQuats.item(k).getParentNode.getParentNode;
   
   posNodes=WhereToAdd.getChildNodes();
   for j = 0:posNodes.getLength-1
       if strcmp(posNodes.item(j).getNodeName(),'position')
           posX = posNodes.item(j).getChildNodes().item(1).getTextContent()
           posY = posNodes.item(j).getChildNodes().item(3).getTextContent()
           posZ = posNodes.item(j).getChildNodes().item(5).getTextContent()
           break;
       end
   end
   
   RPY_node = DOMnode.createElement('relative_pose');
   RPY_node.setAttribute('x',posX);
   RPY_node.setAttribute('y',posY);
   RPY_node.setAttribute('z',posZ);
   RPY_node.setAttribute('roll',num2str(rad2deg(Roll)));
   RPY_node.setAttribute('pitch',num2str(rad2deg(Pitch)));
   RPY_node.setAttribute('yaw',num2str(rad2deg(Yaw)));
   WhereToAdd.appendChild(RPY_node);

  end

  xmlwrite([filename,'_'],DOMnode);
  
end


%<relative_pose x="94.2525" y="381.668" z="-1473.15" yaw="-90" pitch="0" roll="0" />
%<quaternion>
%						<x>0</x>
%						<y>0</y>
%						<z>0</z>
%						<w>1</w>
%</quaternion>

