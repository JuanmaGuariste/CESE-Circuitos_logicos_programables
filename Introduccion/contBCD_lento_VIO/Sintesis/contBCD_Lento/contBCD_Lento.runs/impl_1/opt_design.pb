
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7z0102default:defaultZ17-349h px� 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px� 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
U
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461h px� 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.386 . Memory (MB): peak = 610.234 ; gain = 13.6562default:defaulth px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px� 
�

Phase %s%s
101*constraints2
1 2default:default27
#Generate And Synthesize Debug Cores2default:defaultZ18-101h px� 
k
)Generating Script for core instance : %s 214*	chipscope2
dbg_hub2default:defaultZ16-329h px� 
�
ICould not generate core for %s. Aborting IP Generation operaion. %s  
	%s189*	chipscope2
dbg_hub2default:default2�
�The current Vivado temporary directory path, 'C:/Users/Juanma/Documents/CESE/CLP/TPs_CLP/Introduccion/contBCD_lento_VIO/Sintesis/contBCD_Lento/contBCD_Lento.runs/impl_1/.Xil/Vivado-3172-DESKTOP-NG7OJN9', is 155 characters. Errors on the host OS will occur when trying to insert logic for debug core 'dbg_hub' when temporary directory paths exceed 146 characters. Please move this Vivado project or the Vivado working directory to a shorter path; alternately consider using the OS subst command to map part of the path to a drive letter.
2default:default2
 2default:defaultZ16-302h px� 
W
BPhase 1 Generate And Synthesize Debug Cores | Checksum: 133f0f928
*commonh px� 
�

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.006 . Memory (MB): peak = 1157.238 ; gain = 0.0002default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
162default:default2
02default:default2
02default:default2
22default:defaultZ4-41h px� 
L

%s failed
30*	vivadotcl2

opt_design2default:defaultZ4-43h px� 
Z
5Implementing debug Cores failed due to earlier errors223*	chipscopeZ16-338h px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Sun Apr  6 19:15:04 20252default:defaultZ17-206h px� 


End Record