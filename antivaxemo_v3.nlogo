globals [
  initial-antivaxxers
  antivaxxers
  initial-activists
  activists
  activistsset
  proactivists
  proactivistset
  nummessages
  probability-doctor-doubt
  o1 o2 od1 fij
  doctor-interaction
  patient-interaction
  message-interaction
  dicounter picounter micounter
  histogram-list
  t h1 h2 h3 h4 h5 h6 h7 h8 h9 h10
  h11 h12 h13 h14 h15 h16 h17 h18 h19 h20 h21
  tekscik
  conversiontime
  isintervention
  isafterintervention
  interventionstart
  interventionend
  afterinterventionend
  startingperiod
  newmessages
  newmessages1
  test
]


breed [patients patient]
breed [doctors doctor]
breed [messages message]
breed [initiators initiator]
breed [propagandists propagandist]



turtles-own [opinion location age]




to setup
  clear-all
  reset-ticks
  set t 0
  ;file-close-all
  ;if file-exists? "evolutiona.txt" [file-delete "evolutiona.txt"]
  ;if file-exists? "histogram.z" [file-delete "histogram.z"]
  ;file-open "histogram.z"
  ;set tekscik "! nx 21 ny"
  ;file-type tekscik
  ;file-write maxsteps
  ;set tekscik "  xmin -1.9 xmax 2 ymin 0 ymax "
  ;file-type tekscik
  ;file-write maxsteps
  ;file-print "   "
  ;file-close
  set isintervention 0
  set startingperiod 92

  create-patients 2000
  ask patients
  [set opinion random-normal centeropinion initialSD
    set shape "person"
    set size 2
    set location (random-float 2)
    if opinion > 2 [set opinion 2]
    if opinion < -2 [set opinion -2]
    set ycor opinion * 40
    if opinion >= 0 [set color scale-color green opinion 2.5 -0.5]
    if opinion < 0 [set color scale-color red opinion -2.5 0.5]
    if opinion > ActivismThreshold [set size 3]
    if opinion < -1 * ActivismThreshold [set size 3]
    set age random 90
    set xcor age
  ]

  set activistsset patients with [opinion < -1 * ActivismThreshold ]

  create-initiators numberinitiators
  ask initiators
  [set opinion -1 * ((random-float (2 - ActivismThreshold)) + ActivismThreshold)
    set shape "face sad"
    set size 3
    set location ((random-float 0.2) - 2)
    if opinion > 2 [set opinion 2]
    if opinion < -2 [set opinion -2]
    set xcor location * 50
    set ycor opinion * 40
    set color red
  ]

  create-propagandists numpropagandists
  ask propagandists
  [set opinion ((random-float (2 - ActivismThreshold)) + ActivismThreshold)
    set shape "face happy"
    set size 3
    set color 95
    set location ((random-float 0.2) - 2)
    if opinion > 2 [set opinion 2]
    if opinion < -2 [set opinion -2]
    set xcor location * 50
    set ycor opinion * 40
  ]

  set initial-antivaxxers count patients with [opinion < -1.0]
  set probability-doctor-doubt initial-antivaxxers / 2000.0
  set conversiontime 0

  create-doctors 100
  ask doctors
  [set size 3
    let choice random-float 1
    ifelse choice < doctorconformism * probability-doctor-doubt
      [set opinion random-float -0.25
      set shape "face neutral"]
      [set opinion 1. + (random-float 1)
      set shape "face happy"]
    set location (2 - (random-float 0.2))
    if opinion > 2 [set opinion 2]
    if opinion < -2 [set opinion -2]
    set xcor location * 50
    set ycor opinion * 40
    if opinion >= 0 [set color scale-color green opinion 2.5 0]
    if opinion < 0 [set color scale-color red opinion -2.5 0]
  ]
  ask patches [
    set pcolor white
    if pycor < 40 * vaccinationthreshold [set pcolor 49]
    if pycor < -40 * ActivismThreshold  [set pcolor 19]
  ]


  reset-ticks
end


to write-message
  set newmessages 0
  set newmessages1 0
  if activists > 0 [
    ask activistsset [
      ; up to 5 messages may be written during a time tick
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
    ]
    set newmessages1 newmessages
  ]

    if (proactivists > 0) and (isafterintervention = 1) [
    ask proactivistset [
      ; up to 10 messages may be written during a time tick - trolls are more active
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
    ]
  ]

    ask initiators [
      if opinion < -1 * ActivismThreshold [
      ; up to 5 messages may be written during a time tick
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      set test random-float 1
      if test < writingprobability [
        hatch-messages 1
        set newmessages (newmessages + 1)]
      ]
    ]


  ask messages [
    if age >= 0 [set age -1]
    set shape "square"
    set size 1
    set xcor age
    set ycor opinion * 40
    if opinion >= 0 [set color scale-color green opinion 2.5 -0.5]
    if opinion < 0 [set color scale-color red opinion -2.5 0.5]
  ]


end

to ageall
  ask patients [
    ifelse (abs opinion) > ActivismThreshold
    [set age age + activistaging]
    [set age age + 1]
    ifelse age > 90  ; create new agent with age 0 and new opinion
    [set age 1
      set opinion random-normal centeropinion initialSD
      if opinion > 2 [set opinion 2]
      if opinion < -2 [set opinion -2]]
    [set xcor age] ; otherwise just shift right
  ]
  ask messages [
    set age age - messageaging
    ifelse age < -90
    [die]
    [set xcor age]
  ]
end

to ask-a-doctor
  ask patients [
    set o1 opinion  ; o1 holds initial opinion of the patient
    let prob random-float 1
    if prob < doctor-visit-ratio [ ; visit to a doctor takes place
      ask one-of doctors [
        set od1 opinion ; opinion of the doctor
        ifelse od1 < 0 and count messages > 0 [    ; uncommitted, doubting doctor
          ask one-of messages [ ; patient turns to messages instead
            set od1 opinion
            set micounter micounter + 1
            if (o1 < -1 * ActivismThreshold) and (o1 < od1) [
              set fij (2 - abs o1) / (2 - FilteringThreshold)] ; anti vaxx activists filter views of lower committment
            if ( o1 < -1 * ActivismThreshold) and (od1 > 0) [set fij 0] ; antivaxx activists have absolute rejection of mesages pro vaccinating
            if (o1 > ActivismThreshold) and (o1 > od1) [
              set fij (2 - abs o1) / (2 - FilteringThreshold)] ; pro vaxx activists filter views of lower committment
            if ( o1 > ActivismThreshold) and (od1 < 0) [set fij 0] ; pro vaxx activists have absolute rejection of mesages anti vaccinating
          ]
        ]
        [
          set dicounter dicounter + 1
          set od1 opinion  ; as before od1 is the interacting party opinion
          if ((abs o1) > FilteringThreshold) and (o1 * od1 < 0 ) [ ; agents above Filtering Threashold take less count of opposing views
            set fij (2 - abs o1) / (2 - FilteringThreshold) ]
          if (o1 < -1 * ActivismThreshold) and (o1 < od1) [
            set fij (2 - abs o1) / (2 - FilteringThreshold)] ; anti vaxx activists filter views of lower committment
          if ( o1 < -1 * ActivismThreshold) and (od1 > 0) [set fij 0] ; antivaxx activists have absolute rejection of views of people pro vaccinating
        ]
      ]  ; end of getting the opinion

      ; patient processes the opinion (from the committed doctor or from messages)
      set o2 ((1 - alpha * fij) * o1 + alpha * fij * od1)
      set opinion o2 ; adjust agents opinion after interacting with a doctor
      set ycor opinion * 40
      ifelse  opinion < -1 * ActivismThreshold [set size 3] [set size 2]
      if opinion >= 0 [set color scale-color green opinion 2.5 -0.5]
      if opinion < 0 [set color scale-color red opinion -2.5 0.5]
    ]
  ]
end

to sample-opinion
  ask patients [
    set o1 opinion
    set fij 1
    ask one-of other turtles [ ; includes random visits to doctors, initiators, activists, messages and other patients
      if breed = patients [    ; meetings with other patients are filtered according to difference of opinions and patient status
        set picounter picounter + 1
        set od1 opinion  ; as before od1 is the interacting party opinion
        if ((abs o1) > FilteringThreshold) and (o1 * od1 < 0 ) [ ; agents above Filtering Threashold take less count of opposing views
          set fij (2 - abs o1) / (2 - FilteringThreshold) ]
        if (o1 < -1 * ActivismThreshold) and (o1 < od1) [
          set fij (2 - abs o1) / (2 - FilteringThreshold)] ; anti vaxx activists filter views of lower committment
        if ( o1 < -1 * ActivismThreshold) and (od1 > 0) [set fij 0] ; antivaxx activists have absolute rejection of views of people pro vaccinating
      ]
      if breed = doctors [    ; meetings with doctors are filtered according to difference of opinions and patient status
        set dicounter dicounter + 1
        set od1 opinion  ; as before od1 is the interacting party opinion
        if ((abs o1) > FilteringThreshold) and (o1 * od1 < 0 ) [ ; agents above Filtering Threashold take less count of opposing views
          set fij (2 - abs o1) / (2 - FilteringThreshold) ]
        if (o1 < -1 * ActivismThreshold) and (o1 < od1) [
          set fij (2 - abs o1) / (2 - FilteringThreshold)] ; anti vaxx activists filter views of lower committment
        if ( o1 < -1 * ActivismThreshold) and (od1 > 0) [set fij 0] ; antivaxx activists have absolute rejection of views of people pro vaccinating
      ]
      if breed = messages [    ; messages are only filtered for activists
        set micounter micounter + 1
        set od1 opinion  ; as before od1 is the interacting party opinion
        if (o1 < -1 * ActivismThreshold) and (o1 < od1) [
          set fij (2 - abs o1) / (2 - FilteringThreshold)] ; anti vaxx activists filter views of lower committment
        if ( o1 < -1 * ActivismThreshold) and (od1 > 0) [set fij 0] ; antivaxx activists have absolute rejection of mesages pro vaccinating
        if (o1 > ActivismThreshold) and (o1 > od1) [
          set fij (2 - abs o1) / (2 - FilteringThreshold)] ; pro vaxx activists filter views of lower committment
        if ( o1 > ActivismThreshold) and (od1 < 0) [set fij 0] ; pro vaxx activists have absolute rejection of mesages anti vaccinating
      ]
    ]
    set o2 ((1 - alpha * fij) * o1 + alpha * fij * od1)
    set opinion o2 ; adjust agents opinion after interaction
    set ycor opinion * 40
    ifelse abs opinion > ActivismThreshold [set size 3] [set size 2]
    if opinion >= 0 [set color scale-color green opinion 2.5 -0.5]
    if opinion < 0 [set color scale-color red opinion -2.5 0.5]
  ]
end

to update-doctors
  set antivaxxers count patients with [opinion < vaccinationthreshold]
  ask doctors [
    set size 3
    let choice random-float 1
    ifelse choice < doctorconformism * antivaxxers / 2000
      [set opinion random-float -0.25
      set shape "face neutral"]
      [set opinion 1. + (random-float 1)
      set shape "face happy"]
    set location (2 - (random-float 0.2))
    if opinion > 2 [set opinion 2]
    if opinion < -2 [set opinion -2]
    set xcor location * 50
    set ycor opinion * 40
    if opinion >= 0 [set color scale-color green opinion 2.5 0]
    if opinion < 0 [set color scale-color red opinion -2.5 0]
  ]
end



to printout-evolution-line
  file-open "evolutiona.txt"
  set nummessages count messages
  ;set histogram-list (list t antivaxxers activists nummessages doctor-interaction patient-interaction message-interaction h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16 h17 h18 h19 h20 h21)
  file-write t
  file-write antivaxxers ;
  file-write activists
  file-write nummessages
  file-write doctor-interaction
  file-write patient-interaction
  file-write message-interaction
  file-print "   ";h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16 h17 h18 h19 h20 h21] ;histogram-list
  file-close
end

to printout-histogram-line
  file-open "histogram.z"

  set nummessages count messages
  set h1 count patients with [opinion < -0.95 * 2 ]
  set h2 count patients with [(opinion < -0.85 * 2) and (opinion >= -0.95 * 2)]
  set h3 count patients with [(opinion < -0.75 * 2) and (opinion >= -0.85 * 2)]
  set h4 count patients with [(opinion < -0.65 * 2) and (opinion >= -0.75 * 2)]
  set h5 count patients with [(opinion < -0.55 * 2) and (opinion >= -0.65 * 2)]
  set h6 count patients with [(opinion < -0.45 * 2) and (opinion >= -0.55 * 2)]
  set h7 count patients with [(opinion < -0.35 * 2) and (opinion >= -0.45 * 2)]
  set h8 count patients with [(opinion < -0.25 * 2) and (opinion >= -0.35 * 2)]
  set h9 count patients with [(opinion < -0.15 * 2) and (opinion >= -0.25 * 2)]
  set h10 count patients with [(opinion < -0.05 * 2) and (opinion >= -0.15 * 2)]
  set h11 count patients with [(opinion < 0.05 * 2) and (opinion >= -0.05 * 2)]
  set h12 count patients with [(opinion < 0.15 * 2) and (opinion >= 0.05 * 2)]
  set h13 count patients with [(opinion < 0.25 * 2) and (opinion >= 0.15 * 2)]
  set h14 count patients with [(opinion < 0.35 * 2) and (opinion >= 0.25 * 2)]
  set h15 count patients with [(opinion < 0.45 * 2) and (opinion >= 0.35 * 2)]
  set h16 count patients with [(opinion < 0.55 * 2) and (opinion >= 0.45 * 2)]
  set h17 count patients with [(opinion < 0.65 * 2) and (opinion >= 0.55 * 2)]
  set h18 count patients with [(opinion < 0.75 * 2) and (opinion >= 0.65 * 2)]
  set h19 count patients with [(opinion < 0.85 * 2) and (opinion >= 0.75 * 2)]
  set h20 count patients with [(opinion < 0.95 * 2) and (opinion >= 0.85 * 2)]
  set h21 count patients with [(opinion <= 2.0) and (opinion >= 0.95 * 2)]
  ;set histogram-list (list t antivaxxers activists nummessages doctor-interaction patient-interaction message-interaction h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16 h17 h18 h19 h20 h21)
  file-write h1
  file-write h2
  file-write h3
  file-write h4
  file-write h5
  file-write h6
  file-write h7
  file-write h8
  file-write h9
  file-write h10
  file-write h11
  file-write h12
  file-write h13
  file-write h14
  file-write h15
  file-write h16
  file-write h17
  file-write h18
  file-write h19
  file-write h20
  file-write h21;histogram-
  file-print "   "
  file-close
end

to intervene
  if isintervention = 1 [   ; intervention
    ask propagandists [     ; during time of intervention propagandists write messages
      hatch-messages 1
    ]
  ]
end

to checkintervention
  if numpropagandists > 0 [   ; all this happens only when there are propagandists
    if isintervention = 0 [   ; creating intervention condition
      if count patients with [opinion < vaccinationthreshold] > interventiontrigger [
        set isintervention 1
        set isafterintervention 1
        set interventionstart t
        set interventionend (t + interventionlength)
        set afterinterventionend (interventionend + afterinterventiontime)
      ]
    ]
    if isintervention = 1 [   ; destroying intervention condition
      if t > interventionend [  ; duration of intervention exceeded
        set isintervention 0 ]
    ]
    if isafterintervention = 1 [   ; destroying after intervention condition
      if t > afterinterventionend [  ; duration of intervention exceeded
        set isafterintervention 0 ]
    ]


  ]
end

to cullmessages
  ask messages [
    set test random-float 1
    if test > (maxmessages / (count messages + 1)) [ die ]
  ]
end


to go
  write-message
  ageall
  if t >= startingperiod [
    set dicounter 0
    set picounter 0
    set micounter 0
    ask-a-doctor
    checkintervention
    intervene
    cullmessages
    sample-opinion
    intervene
    set doctor-interaction dicounter
    set patient-interaction picounter
    set message-interaction micounter
    set activists count patients with [opinion < -1 * ActivismThreshold ]
    set proactivists count patients with [opinion > ActivismThreshold]
    ifelse conversiontime > 0 [
      stop
    ]
    [
      if activists > 1600   [set conversiontime t]
    ]
    set activistsset patients with [opinion < -1 * ActivismThreshold ]
    set proactivistset patients with [opinion > ActivismThreshold ]
    update-doctors
    ;printout-evolution-line
    ;printout-histogram-line
  ]
  set t t + 1
  tick

  if ticks > maxsteps + 2 + startingperiod [
    ;file-open "histogram.z"
    ;file-print "   "

    ;file-close-all
    stop]




end
@#$#@#$#@
GRAPHICS-WINDOW
860
22
1873
836
-1
-1
5.0
1
10
1
1
1
0
0
0
1
-100
100
-80
80
1
1
1
ticks
30.0

SLIDER
39
127
211
160
ActivismThreshold
ActivismThreshold
1
2
1.8
0.01
1
NIL
HORIZONTAL

SLIDER
39
170
211
203
FilteringThreshold
FilteringThreshold
0
2
1.0
0.1
1
NIL
HORIZONTAL

BUTTON
146
38
209
71
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
40
38
103
71
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
39
272
211
305
centeropinion
centeropinion
-2
2
0.0
0.1
1
NIL
HORIZONTAL

SLIDER
40
327
212
360
initialSD
initialSD
0
1
0.5
0.05
1
NIL
HORIZONTAL

SLIDER
39
84
211
117
numberinitiators
numberinitiators
0
10
1.0
1
1
NIL
HORIZONTAL

SLIDER
42
380
214
413
writingprobability
writingprobability
0
1
0.45
0.01
1
NIL
HORIZONTAL

SLIDER
44
430
216
463
doctor-visit-ratio
doctor-visit-ratio
0
1
0.15
0.01
1
NIL
HORIZONTAL

SLIDER
44
520
216
553
alpha
alpha
0
1
0.66
0.01
1
NIL
HORIZONTAL

SLIDER
40
220
212
253
vaccinationthreshold
vaccinationthreshold
-2
0
-1.0
0.05
1
NIL
HORIZONTAL

PLOT
463
23
807
173
Antivaxxers
time
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot count patients with [opinion < vaccinationthreshold]"

PLOT
464
193
808
343
Doubting doctors
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"pen-1" 1.0 0 -13791810 true "" "plot count doctors with [opinion < 0]"

PLOT
464
365
808
515
Messages in the system
time
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" "plot count messages"
"pen-1" 1.0 0 -11085214 true "" "plot count messages with [opinion > 0]"
"pen-2" 1.0 0 -2674135 true "" "plot count messages with [opinion < 0]"

PLOT
38
690
378
840
Opinion distribution
opinion
NIL
-2.0
2.0
0.0
500.0
false
false
"" ""
PENS
"default" 0.1 1 -16777216 true "" "histogram [opinion] of patients"

PLOT
465
527
808
677
New Activists
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot count patients with [opinion < -1 * ActivismThreshold]"
"pen-1" 1.0 0 -14439633 true "plot count patients with [opinion > ActivismThreshold]" ""

SLIDER
45
477
218
510
doctorconformism
doctorconformism
0
1
0.5
0.02
1
NIL
HORIZONTAL

INPUTBOX
44
613
221
673
maxsteps
20100.0
1
0
Number

MONITOR
246
618
343
663
NIL
conversiontime
0
1
11

SLIDER
44
568
217
601
maxmessages
maxmessages
0
3000
2000.0
100
1
NIL
HORIZONTAL

SLIDER
249
269
422
302
interventiontrigger
interventiontrigger
0
500
220.0
20
1
NIL
HORIZONTAL

SLIDER
250
324
423
357
numpropagandists
numpropagandists
0
20
0.0
1
1
NIL
HORIZONTAL

SLIDER
249
378
422
411
interventionlength
interventionlength
0
50
20.0
1
1
NIL
HORIZONTAL

MONITOR
246
567
342
612
NIL
isintervention
0
1
11

SLIDER
248
433
428
466
afterinterventiontime
afterinterventiontime
0
50
40.0
5
1
NIL
HORIZONTAL

MONITOR
246
519
342
564
NIL
isafterintervention
0
1
11

SLIDER
253
88
426
121
messageaging
messageaging
1
6
5.0
1
1
NIL
HORIZONTAL

SLIDER
255
138
428
171
activistaging
activistaging
1
6
3.0
1
1
NIL
HORIZONTAL

PLOT
467
696
810
846
New Messages
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot newmessages1"

@#$#@#$#@
## WHAT IS IT?

The model intends to provida a dynamic environment to simulate the anti-vaccination movement. 

## HOW IT WORKS

There are four types og agents in the model. The main group is formed by 2000 "_patients_" - agents who might support vaccination or oppose it. This is measured by agents "_opinion_" variable, limited between -2 (strong anti-vaccination) and +2 (strong pro-vaccination).
Depending on the current value of an agent's opinion it may "decide" to vaccinate, or not. The threshold for vaccination os determined by the "_vaccinationthreshold_" variable. Its suggested value is -1, which corresponds to assumption that anti-vaccination opinion must be quite strong to overcome social and legal pressures imposed by the state to promote vaccination.

_Patients_ are created with a normal distribution of opinions, detemined by the centre (_centreopinion_) and Standard Deviation (_initialSD_). Agents "age" with each program steps by two units (which is shown by a shift to the right in the model visual panel). Upon reaching the age of 90 time units (which may correspond to weeks or months, for example), the _patient_ exits the pool and is replaced by a new one with opinion drawn from the same distribution. This aging process corresponds to limited time window in which typical agents are concerned with vaccination (e.g. "window" of MMR vaccination of children). 

_Patients_ can change their opinions through interactions with other agents in the model. A _patient_ with _opinion_ o1, interacting with another agent with _opinion_ o2 will change its opinion according to the formula
o1' = (1-alpha fij) o1 + alpha fij o2,
where _alpha_ determines the tempo of adoption of others' opinion (suggested values 0.5 or 0.67); and _fij_ is the filtering factor, describing the decrease of influence of opinions far from the current opinion o1. 

_Patients_ with _opinion_ below _activismthreshold_ become anti-vaccination activists

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

person doctor
false
0
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Polygon -13345367 true false 135 90 150 105 135 135 150 150 165 135 150 105 165 90
Polygon -7500403 true true 105 90 60 195 90 210 135 105
Polygon -7500403 true true 195 90 240 195 210 210 165 105
Circle -7500403 true true 110 5 80
Rectangle -7500403 true true 127 79 172 94
Polygon -1 true false 105 90 60 195 90 210 114 156 120 195 90 270 210 270 180 195 186 155 210 210 240 195 195 90 165 90 150 150 135 90
Line -16777216 false 150 148 150 270
Line -16777216 false 196 90 151 149
Line -16777216 false 104 90 149 149
Circle -1 true false 180 0 30
Line -16777216 false 180 15 120 15
Line -16777216 false 150 195 165 195
Line -16777216 false 150 240 165 240
Line -16777216 false 150 150 165 150

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="AT18" repetitions="20" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20200"/>
    <metric>count messages</metric>
    <metric>newmessages</metric>
    <metric>count patients with [opinion &lt; -1 * ActivismThreshold]</metric>
    <enumeratedValueSet variable="maxsteps">
      <value value="20100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccinationthreshold">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="writingprobability">
      <value value="0.45"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="afterinterventiontime">
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numberinitiators">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxmessages">
      <value value="2000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventionlength">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctor-visit-ratio">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialSD">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctorconformism">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="centeropinion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="FilteringThreshold">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActivismThreshold">
      <value value="1.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventiontrigger">
      <value value="220"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numpropagandists">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Intervention100" repetitions="20" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="20101"/>
    <metric>count patients with [opinion &lt; vaccinationthreshold]</metric>
    <metric>count patients with [opinion &lt; -1 * Activismthreshold]</metric>
    <metric>count patients with [opinion &gt; Activismthreshold]</metric>
    <metric>count messages with [opinion &lt; 0]</metric>
    <metric>count messages with [opinion &gt; 0]</metric>
    <enumeratedValueSet variable="maxsteps">
      <value value="20100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccinationthreshold">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="writingprobability">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="afterinterventiontime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numberinitiators">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxmessages">
      <value value="2000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventionlength">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctor-visit-ratio">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialSD">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctorconformism">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="centeropinion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="FilteringThreshold">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActivismThreshold">
      <value value="1.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventiontrigger">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numpropagandists">
      <value value="4"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="FFT" repetitions="10" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>newmessages</metric>
    <enumeratedValueSet variable="maxsteps">
      <value value="20100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccinationthreshold">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="afterinterventiontime">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="writingprobability">
      <value value="0.3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numberinitiators">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxmessages">
      <value value="2000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventionlength">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctor-visit-ratio">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialSD">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctorconformism">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="centeropinion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="FilteringThreshold">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActivismThreshold">
      <value value="1.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventiontrigger">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numpropagandists">
      <value value="0"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>count turtles</metric>
    <enumeratedValueSet variable="maxsteps">
      <value value="20100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="vaccinationthreshold">
      <value value="-1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="afterinterventiontime">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="writingprobability">
      <value value="0.4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numberinitiators">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxmessages">
      <value value="2000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.66"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventionlength">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctor-visit-ratio">
      <value value="0.15"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="initialSD">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="doctorconformism">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="activistaging">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="centeropinion">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="FilteringThreshold">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="interventiontrigger">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ActivismThreshold">
      <value value="1.7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="numpropagandists">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="messageaging">
      <value value="5"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
