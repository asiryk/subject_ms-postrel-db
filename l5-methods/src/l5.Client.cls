Class l5.Client Extends l5.User
{

Relationship ManagerRel As l5.Manager [ Cardinality = one, Inverse = ClientRel ];

Property Orders As list Of l5.Order;

Property Age As %Integer [ Calculated, SqlComputeCode = {set Age = ##class(l5.Client).CalculateAge(BirthDate)}, SqlComputed ];

ClassMethod CalculateAge(DOB As %Date) As %Integer
{
    #; 8 - YYYYMMDD (19970701 or 20020327) — Numeric format
    Quit $ZDate($HOROLOG, 8)-$ZDate(DOB, 8) \ 10000
}

Method GetAge() As %Integer [ CodeMode = expression, ServerOnly = 1 ]
{
##class(l5.Client).CalculateAge(..BirthDate)
}

Storage Default
{
<Data name="ClientDefaultData">
<Subscript>"Client"</Subscript>
<Value name="1">
<Value>ManagerRel</Value>
</Value>
<Value name="2">
<Value>Orders</Value>
</Value>
</Data>
<DefaultData>ClientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
