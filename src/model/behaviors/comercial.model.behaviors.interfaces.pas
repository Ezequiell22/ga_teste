unit comercial.model.behaviors.interfaces;

interface

type
  iModelBehaviorsSlack = interface
    ['{88E46351-4397-4B6C-BFBC-4778543F91FD}']
    function MessageSend(aValue: string): iModelBehaviorsSlack;
  end;

  iModelBehaviorsTelegram = interface
    ['{D14E352D-2D13-4D99-84C5-295E9575370B}']
    function MessageSend(aValue: string): iModelBehaviorsTelegram;
    function MessageSendWithImage(aMessage, aImagePath: string): iModelBehaviorstelegram;
  end;

implementation

end.
