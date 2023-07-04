% Progressing Function
function progressFunc(t)
    stepTime = t / 100;
    f = waitbar(0,'1','Name','~ ABAY PRODUCTION ~',...
        'CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
    setappdata(f,'canceling',0);
    steps = 100;
    for step = 1 : steps
        % Check for clicked Cancel button
        if getappdata(f,'canceling')
            break
        end
        % Update waitbar and message
        waitbar(step/steps, f, sprintf('Progressing... %d/100',step))
        pause(stepTime)
    end
    delete(f)
end