function [Route_Receive,Route_Insert] = Insert_Route(Init_Path,Receive_Index,Insert_Index,Insert_Position)
Receive_Path = Init_Path{Insert_Index};
Insert_Path = Init_Path{Receive_Index};
Insert_Length = length(Insert_Path);
if Insert_Position == 1
    Route_Receive = [Receive_Path,Insert_Path];
elseif Insert_Position == Insert_Length + 1
    Route_Receive = [Insert_Path,Receive_Path];
else
    Route_Receive = [Insert_Path(1:Insert_Position-1),Receive_Path,Insert_Path(Insert_Position:end)];
end
Route_Insert = [];