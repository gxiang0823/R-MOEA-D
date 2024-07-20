function Init_Pop = ICW_Init(Cusnum_Number,Dist_Table,Target_Demand,Cap)         %CW Algorithm
%% Initial Path
Init_Path = cell(Cusnum_Number,1);
for i =1:Cusnum_Number
    Init_Path{i} = i;
end

%% Initial Savings Table
Save_Table = Calculate_MileageSavings(Init_Path,Dist_Table,Target_Demand);

%% Saving optimization stage
Operate_Position = 1;
while Save_Table(1,1)>0
    Save_Table = Calculate_MileageSavings(Init_Path,Dist_Table,Target_Demand);
    if ~isempty(Save_Table)
        Receive_Index = Save_Table(:,2);
        Insert_Index = Save_Table(:,3);
        Insert_Position = Save_Table(:,4);
        [Route_Receive,Route_Insert] = Insert_Route(Init_Path,Receive_Index(1),Insert_Index(1),Insert_Position(1));
        Path_Load = Calculate_PathLoad(Route_Receive,Target_Demand);
        if Path_Load <= Cap
            %Update_Path
            Init_Path{Receive_Index(1)} = Route_Receive;
            Init_Path{Insert_Index(1)} = Route_Insert;
            Operate_Position = 1;
        else
            Operate_Position = Operate_Position + 1;
            if Operate_Position <= size(Receive_Index,1)
                [Route_Receive,Route_Insert] = Insert_Route(Init_Path,Receive_Index(Operate_Position),Insert_Index(Operate_Position),Insert_Position(Operate_Position));
                Path_Load = Calculate_PathLoad(Route_Receive,Target_Demand);
                if Path_Load <= Cap
                    %Update_Path
                    Init_Path{Receive_Index(Operate_Position)} = Route_Receive;
                    Init_Path{Insert_Index(Operate_Position)} = Route_Insert;
                    Operate_Position = 1;
                end
            else
                break;
            end
        end
    else
        break;
    end
end
Init_Path(cellfun(@isempty,Init_Path))=[];
Init_Pop = Init_Path;
