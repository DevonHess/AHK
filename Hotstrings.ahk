; Personal

::na::Devon Hess

::fna::Devon Alexander Hess

::em::DevonAlexanderHess@gmail.com

::pn::19042549864

::ad::132 Sawmill Lakes BLVD, Ponte Vedra Beach, FL

::sig::
	SendInput, na{Enter}
Return

::d::
	FormatTime, CurrentDateTime,,M/d/yyyy
	SendInput %CurrentDateTime%
Return

::t::
	FormatTime, CurrentDateTime,,h:mm tt
	SendInput %CurrentDateTime%
Return

::ts::
	FormatTime, CurrentDateTime
	SendInput %CurrentDateTime%
Return
